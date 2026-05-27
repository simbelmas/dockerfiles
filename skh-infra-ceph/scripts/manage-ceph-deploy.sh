#!/bin/bash
set -euo pipefail
#
# One bootstrap node (CEPH_BOOTSTRAP_LEADER or first name after sort -u in ceph_cluster_members).
# Everyone else waits and joins. List each member exactly as "hostname -f" on that host.
#

# shellcheck source=/dev/null
source /etc/fediceph/ceph-cluster-vars

: "${ceph_cluster_members[@]:?ceph_cluster_members must be set in ceph-cluster-vars}"

echo "# Starting Ceph lifecycle management"

CEPH_FSID="${CEPH_FSID:-35b0826b-eaf3-4a4e-bd38-df8a20d5700b}"
CEPH_DISCOVERY_INITIAL_WAIT="${CEPH_DISCOVERY_INITIAL_WAIT:-120}"
CEPH_DISCOVERY_PASSES="${CEPH_DISCOVERY_PASSES:-5}"
CEPH_DISCOVERY_SLEEP="${CEPH_DISCOVERY_SLEEP:-15}"
CEPH_STAGGER_MAX="${CEPH_STAGGER_MAX:-45}"
CEPH_WAIT_FOR_CLUSTER="${CEPH_WAIT_FOR_CLUSTER:-0}"
CEPH_JOIN_MAX_WAIT="${CEPH_JOIN_MAX_WAIT:-7200}"
CEPH_JOIN_SLEEP="${CEPH_JOIN_SLEEP:-15}"

this_host="$(hostname -f)"

ceph_units_present() {
  local out
  out=$(systemctl list-units --all --no-legend 2>/dev/null | grep -E 'ceph@|ceph\.target' | grep -v ceph-node-lifecycle || true)
  [[ -n "$out" ]]
}

peer_has_ceph() {
  local node="$1"
  [[ "$node" == "$this_host" ]] && return 1
  local out
  if ! out=$(ssh -o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no \
      "$node" 'systemctl list-units --all --no-legend 2>/dev/null | grep -E "ceph@|ceph\.target" | grep -v ceph-node-lifecycle || true' 2>/dev/null); then
    return 1
  fi
  [[ -n "$(echo "$out" | tr -d '[:space:]')" ]]
}

sorted_members() {
  local -a sorted
  mapfile -t sorted < <(printf '%s\n' "${ceph_cluster_members[@]}" | sort -u)
  printf '%s\n' "${sorted[@]}"
}

bootstrap_candidate() {
  if [[ -n "${CEPH_BOOTSTRAP_LEADER:-}" ]]; then
    echo "$CEPH_BOOTSTRAP_LEADER"
    return
  fi
  sorted_members | head -n1
}

is_bootstrap_candidate() {
  [[ "$this_host" == "$(bootstrap_candidate)" ]]
}

discover_peer_once() {
  local node
  for node in "${ceph_cluster_members[@]}"; do
    [[ "$node" == "$this_host" ]] && continue
    if peer_has_ceph "$node"; then
      echo "$node"
      return 0
    fi
  done
  return 1
}

discover_existing_cluster() {
  local pass node
  for ((pass = 1; pass <= CEPH_DISCOVERY_PASSES; pass++)); do
    if node=$(discover_peer_once); then
      echo "# Found Ceph on peer ${node} (pass ${pass})" >&2
      echo "$node"
      return 0
    fi
    echo "# Discovery pass ${pass}/${CEPH_DISCOVERY_PASSES}: no peer with Ceph yet, sleep ${CEPH_DISCOVERY_SLEEP}s" >&2
    sleep "$CEPH_DISCOVERY_SLEEP"
  done
  return 1
}

default_src_ip() {
  ip -4 route get 1.0.0.0 2>/dev/null | grep -oP 'src \K\S+' && return 0
  ip -4 route show default 2>/dev/null | grep -oP 'src \K\S+' | head -n1
}

wait_for_network_and_stagger() {
  echo "# Waiting up to ${CEPH_DISCOVERY_INITIAL_WAIT}s for default route"
  local waited=0 step=5
  while (( waited < CEPH_DISCOVERY_INITIAL_WAIT )); do
    if ip route get 1 >/dev/null 2>&1; then
      break
    fi
    sleep "$step"
    waited=$((waited + step))
  done
  if [[ "${CEPH_STAGGER_MAX}" -gt 0 ]]; then
    local jitter=$((RANDOM % (CEPH_STAGGER_MAX + 1)))
    echo "# Stagger ${jitter}s"
    sleep "$jitter"
  fi
}

run_bootstrap() {
  echo "# Bootstrap on this node"
  set -x
  cephadm bootstrap \
    --fsid "$CEPH_FSID" \
    --mon-id "$this_host" \
    --mgr-id "$this_host" \
    --mon-ip "$(default_src_ip)" \
    --no-minimize-config \
    --allow-fqdn-hostname \
    --ssh-public-key /var/roothome/.ssh/id_ed25519.pub \
    --ssh-private-key /var/roothome/.ssh/id_ed25519 \
    --ssh-config /var/roothome/.ssh/config \
    --skip-monitoring-stack
  set +x
  cephadm shell -- ceph orch client-keyring set client.admin label:_admin
  cephadm shell -- ceph orch host label add "$this_host" _admin
  ## Noout management 
  #set noout to 48h
  cephadm shell -- ceph config set global mon_osd_down_out_interval 172800
  #cephadm shell -- ceph osd set noout || true
}

orch_host_count() {
  cephadm shell --fsid "$CEPH_FSID" -- ceph orch host ls 2>/dev/null | awk 'NR>1 && $1 != "" { n++ } END { print n+0 }'
}

wait_hosts_and_apply_services() {
  echo "Waiting for at least 3 hosts in orch"
  while true; do
    local count
    count=$(orch_host_count || echo 0)
    if [[ "${count:-0}" -ge 3 ]]; then
      break
    fi
    echo "Hosts: ${count:-0}, sleep 10"
    sleep 10
  done
  echo "Applying ceph-services.yaml"
  while ! cat /etc/fediceph/ceph-services.yaml | cephadm shell -- ceph orch apply -i - ; do
    echo "Orch apply failed, retrying in 10 secs"
    sleep 10
  done
  ## wait for hdd class to be created

  ## Create crush rules
  while [[ -z "$(cephadm shell -- ceph osd crush class ls | grep hdd)" ]] ; do
    echo "Waiting for hdd class to appear to create crush rule"
    sleep 10
  done
  set -x
  cephadm shell -- ceph osd crush rule create-replicated hdd_host_rule default host hdd
  set +x
  while [[ -z "$(cephadm shell -- ceph osd crush rule ls | grep hdd_host_rule)" ]] ; do
    echo "Waiting for crush rule to be assigned."
    sleep 10
  done
  set -x
  ## Set pool default size to 2 and allow using pool if replica is 1
  cephadm shell -- ceph config set global osd_pool_default_crush_rule $(cephadm shell -- ceph osd crush rule dump hdd_host_rule | jq -r .rule_id)
  cephadm shell -- ceph config set global osd_pool_default_size 3
  set +x
  ## the following has to be done at the end since it may fail if no osd is available (eg after reinstallation without wiping disks)
  ## Migrate mgr pool to this rule (wait a bit after defautl pool size set to 2 to le tmgr create it)
  while [[ -z "$(cephadm shell -- ceph osd pool ls | grep .mgr )" ]] ; do
    echo "Waiting for .mgr pool to appear"
    sleep 10
  done
  set -x
  cephadm shell -- ceph osd pool set .mgr min_size 2
  cephadm shell -- ceph osd pool set .mgr crush_rule hdd_host_rule

  ## increase numbe rof pg per osd
  cephadm shell -- ceph config set global mon_max_pg_per_osd 300
  ## Temp dashbord user config, remove when exploration done. dont care if it fails
  cephadm shell -- ceph dashboard ac-user-create admin -i <(echo 'adminPassword1') administrator || true
  ## Delete defautl crush rule 
  cephadm shell -- ceph osd crush rule rm replicated_rule
  ## Enable mgr prometheus exporter
  cephadm shell -- ceph mgr module enable prometheus

  ## Log to stdout instead of fs
  # ceph-volume remains on /var/log/ceph
  # 1. Disable logging to files cluster-wide
  ceph config set global log_to_file false
  ceph config set global mon_cluster_log_to_file false

  # 2. Ensure logging to journald/stderr is active
  ceph config set global log_to_stderr true
  ceph config set global log_to_journald true

  ## Create rbd pools
  # --- 2-replicas pool ---
  cephadm shell -- ceph osd pool create kube_hdd_replica_2 32 replicated hdd_host_rule
  cephadm shell -- ceph osd pool set kube_hdd_replica_2 size 2
  cephadm shell -- ceph osd pool set kube_hdd_replica_2 min_size 1
  cephadm shell -- ceph osd pool application enable kube_hdd_replica_2 rbd
  cephadm shell -- ceph osd pool set kube_hdd_replica_2 bulk true

  # --- 3-replicas pool ---
  cephadm shell -- ceph osd pool create kube_hdd_replica_3 32 replicated hdd_host_rule
  cephadm shell -- ceph osd pool set kube_hdd_replica_3 size 3
  cephadm shell -- ceph osd pool set kube_hdd_replica_3 min_size 2
  cephadm shell -- ceph osd pool application enable kube_hdd_replica_3 rbd
  cephadm shell -- ceph osd pool set kube_hdd_replica_3 bulk true

  ## Create cephfs pools
  # --- Metadata Pool (The Brain) ---
  cephadm shell -- ceph osd pool create cephfs_metadata 32 replicated hdd_host_rule
  ### increment size when new osd here
  cephadm shell -- ceph osd pool set cephfs_metadata size 3
  cephadm shell -- ceph osd pool set cephfs_metadata min_size 2  

  # --- Data Pool: Replica 2 ---
  cephadm shell -- ceph osd pool create cephfs_data_r2 32 replicated hdd_host_rule
  cephadm shell -- ceph osd pool set cephfs_data_r2 size 2
  cephadm shell -- ceph osd pool set cephfs_data_r2 min_size 1
  cephadm shell -- ceph osd pool set cephfs_data_r2 bulk true

  # --- Data Pool: Replica 3 ---
  cephadm shell -- ceph osd pool create cephfs_data_r3 32 replicated hdd_host_rule
  cephadm shell -- ceph osd pool set cephfs_data_r3 size 3
  cephadm shell -- ceph osd pool set cephfs_data_r3 min_size 2
  cephadm shell -- ceph osd pool set cephfs_data_r3 bulk true

  # Create the FS using the R2 pool as the primary data pool and add r3 pool
  cephadm shell -- ceph fs new kube_cephfs cephfs_metadata cephfs_data_r2
  cephadm shell -- ceph fs add_data_pool kube_cephfs cephfs_data_r3

  cephadm shell -- ceph osd pool application enable cephfs_metadata cephfs
  cephadm shell -- ceph osd pool application enable cephfs_data_r2 cephfs
  cephadm shell -- ceph osd pool application enable cephfs_data_r3 cephfs
  
  # --- Metadata pool : Replica 3 ---
  cephadm shell -- ceph osd pool set cephfs_metadata size 3
  cephadm shell -- ceph osd pool set cephfs_metadata min_size 2

  # create subvolume group
  cephadm shell -- ceph fs subvolumegroup create kube_cephfs csi
  # Deploy mds
  cephadm shell -- ceph orch apply mds kube_cephfs 3
  #allow hot standby to replay metadata directly, it enhances fallback speedup
  cephadm shell -- ceph fs set kube_cephfs allow_standby_replay true
  
  ## reduce bluestore warning lifetime
  ceph config set osd bluestore_slow_ops_warn_lifetime 900
  set +x
}

join_existing_cluster() {
  local orch="$1"
  if [[ "$orch" == "$this_host" ]]; then
    echo "join_existing_cluster: orchestrator is this host; fix ceph_cluster_members to use the same FQDN as hostname -f everywhere." >&2
    exit 1
  fi

  local t0=$SECONDS ip
  ip=$(default_src_ip)
  [[ -n "$ip" ]] || { echo "no default src ip" >&2; exit 1; }

  echo "# Join via ${orch}"
  while (( SECONDS - t0 < CEPH_JOIN_MAX_WAIT )); do
    local host_ls
    if ! host_ls=$(ssh -o BatchMode=yes -o ConnectTimeout=15 -o StrictHostKeyChecking=no \
        "$orch" cephadm shell -- ceph orch host ls 2>/dev/null); then
      echo "ssh ceph orch host ls failed, sleep ${CEPH_JOIN_SLEEP}s" >&2
      sleep "$CEPH_JOIN_SLEEP"
      continue
    fi

    if echo "$host_ls" | grep -qi 'no orchestrator'; then
      echo "no orchestrator yet, sleep ${CEPH_JOIN_SLEEP}s" >&2
      sleep "$CEPH_JOIN_SLEEP"
      continue
    fi

    if echo "$host_ls" | grep -Fq "$this_host"; then
      echo "already in orch host ls"
      return 0
    fi

    echo "ceph orch host add ${this_host} ${ip}"
    if ssh -o BatchMode=yes -o ConnectTimeout=20 -o StrictHostKeyChecking=no \
        "$orch" cephadm shell -- ceph orch host add "$this_host" "$ip" _admin; then
      sleep 5
      if host_ls=$(ssh -o BatchMode=yes -o ConnectTimeout=15 -o StrictHostKeyChecking=no \
          "$orch" cephadm shell -- ceph orch host ls 2>/dev/null); then
        if echo "$host_ls" | grep -Fq "$this_host"; then
          return 0
        fi
      fi
      echo "host add ok but not listed yet, retry" >&2
    else
      echo "ceph orch host add failed, sleep ${CEPH_JOIN_SLEEP}s" >&2
    fi
    sleep "$CEPH_JOIN_SLEEP"
  done

  echo "join timed out after ${CEPH_JOIN_MAX_WAIT}s" >&2
  exit 1
}

non_leader_wait_for_cluster() {
  local deadline step=20
  [[ "$CEPH_WAIT_FOR_CLUSTER" -gt 0 ]] && deadline=$((SECONDS + CEPH_WAIT_FOR_CLUSTER))
  while true; do
    local found
    if found=$(discover_peer_once); then
      echo "# peer ${found}" >&2
      join_existing_cluster "$found"
      return 0
    fi
    if [[ "$CEPH_WAIT_FOR_CLUSTER" -gt 0 && "$SECONDS" -ge "$deadline" ]]; then
      echo "wait for cluster timed out" >&2
      exit 3
    fi
    sleep "$step"
  done
}

# --- main ---

if ceph_units_present; then
  echo "ceph already here"
  cephadm version
  cephadm disk-rescan || true
  exit 0
fi

wait_for_network_and_stagger

ceph_installed_on=""
if peer=$(discover_existing_cluster); then
  ceph_installed_on="$peer"
fi

if [[ -n "$ceph_installed_on" ]]; then
  join_existing_cluster "$ceph_installed_on"
  exit 0
fi

if is_bootstrap_candidate; then
  echo "# bootstrap as $(bootstrap_candidate)"
  run_bootstrap
  wait_hosts_and_apply_services
else
  echo "# wait for $(bootstrap_candidate) to bootstrap"
  non_leader_wait_for_cluster
fi
