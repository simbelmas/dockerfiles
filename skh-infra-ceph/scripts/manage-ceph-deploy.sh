#!/bin/bash -e

source /etc/fediceph/ceph-cluster-vars

echo "# Starting Ceph lifecycle management"
random_delay=$(( RANDOM % 31))
echo "Waiting for ${random_delay} seconds to avoid race conditions"
#sleep ${random_delay}

if ! cat /etc/fediceph/ceph-services.yaml | cephadm shell -- ceph orch apply -i - ; then
      echo "Didnt suceeded to apply services configuration, please apply it manually" >&2
      exit 2
    fi


# Determine if ceph is installed on the host
if [[ -n "$(systemctl list-units | grep ceph)" ]] ; then
  echo "Ceph is installed on the host"
  cephadm version
  ## rescen retunrs 1 if no new device is found
  cephadm disk-rescan || true
else
  # Check if ceph cluster is deployed in other nodes
  ceph_installed_on=no
  for node in "${ceph_cluster_members[@]}" ; do
    if [[ "${node}" == "$(hostname -f)" ]] ; then
      continue
    fi
    if [[ -n "$(ssh ${node} systemctl list-units | grep ceph)" ]] ; then
      ceph_installed_on=${node}
      break
    fi
  done
  if [[ "${ceph_installed_on}" == "no" ]] ; then
    echo "# Boostrapping ceph cluster"
    (
      set -x
      cephadm bootstrap --fsid 35b0826b-eaf3-4a4e-bd38-df8a20d5700b --mon-id $(hostname -f) --mgr-id $(hostname -f) --mon-ip $(ip route | grep -oP '^default.*src \K\S+')  --no-minimize-config --allow-fqdn-hostname --ssh-public-key /var/roothome/.ssh/id_ed25519.pub --ssh-private-key /var/roothome/.ssh/id_ed25519 --ssh-config /var/roothome/.ssh/config --skip-monitoring-stack
      cephadm shell -- ceph orch client-keyring set client.admin label:_admin
      cephadm shell -- ceph orch host label add $(hostname -f) _admin
    )
    echo "Waiting that at least 3 nodes join the cluster to apply configuration"
    while true ; do
      number_of_hosts=$( cephadm shell --fsid 35b0826b-eaf3-4a4e-bd38-df8a20d5700b -- ceph  orch host ls | grep -oP '^[\d]+' | grep -v Infering)
      if [[ "${number_of_hosts}" -lt 3 ]] ; then
	      echo "Only ${number_of_hosts} in cluster, waiting hosts to apply configuration"
      else
	      break
      fi
      sleep 10
    done
    echo "Applying services configuration"
    if ! cat /etc/fediceph/ceph-services.yaml | cephadm shell -- ceph orch apply -i - ; then
      echo "Didnt suceeded to apply services configuration, please apply it manually" >&2
      exit 2
    fi
  else
  echo  Ceph installed ${ceph_installed_on}, benching node status
  while true ; do
    if host_ls=$(ssh ${ceph_installed_on} cephadm shell -- ceph orch host ls) ; then
      if [[ -n "$(echo ${host_ls} | grep 'No orchestrator configured')" ]] ; then
        echo "Orchestrator is not yet ready, cluster may be boostrapping, retry in 10 seconds"
        sleep 10
        continue
      fi
      if [[ -z "$(echo ${host_ls} | grep "$(hostname -f)")" ]] ; then
        echo "Node is not managed by the cluster, insert it"
        (
          set -x
          ssh ${ceph_installed_on} cephadm shell -- ceph orch host add $(hostname -f) $(ip route | grep -oP '^default.*src \K\S+') _admin
        )
        break
      else
        echo "Nothing to do, ceph manage already added node."
      fi
    fi
  done
  fi
fi


