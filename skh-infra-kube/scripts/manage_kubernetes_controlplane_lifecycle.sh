#!/bin/bash -e

kubeadm_config_file=/etc/kubernetes/kubeadm-config.yaml

source /usr/local/lib/shell_utilities_functions.zsh
source /etc/kubernetes/fedora-kube.d/*.conf

echo -e "\n\n\n### Starting kubernetes lifecycle management service"

## Preflight checks
echo Kubernetes desired version: "${KUBERNETES_DESIRED_VERSION}"

echo -e "\n## Validating kubeadm configuration"
kubeadm config validate --config ${kubeadm_config_file}

## Manage cluster lifecycle
echo -e "\n## Managing cluster initialisation"
## Initialize cluster if not already done
### First check if admin kubeconfig, exists
if [[ ! -f "${KUBECONFIG}" ]] ; then
## TODO: Add more checks
    echo "No admin kubeconfig found, initializing the cluster ..."
    kubeadm init --config "${kubeadm_config_file}"
    #Waiting cluster to be initialized
    sleep 15
else
    echo "Cluster already initialized, continuing ..."
fi

echo -e "\n## Managing flannel cni"
flannel_configuration=$(curl -sL https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml | sed 's#10.244.0.0/16#'${KUBERNETES_POD_NETWORK}'#g' | kubectl apply -f -)
echo "${flannel_configuration}"
if [[ -n "$(echo "${flannel_configuration}" | grep 'configured|created')" ]] ; then
    systemctl restart crio
    ip link del cni0
fi

echo -e "\n## Managing upgrades"
attempt=1
while [[ "${attempt}" -le 5 ]] ; do
    echo "Attempting to get upgrade plan (${attempt}/5)"
    if upgrade_plan=$(kubeadm upgrade plan); then
        break
    fi
    attempt=$(( attempt + 1 ))
    sleep 5
done

cluster_version=$(echo "${upgrade_plan}" | awk 'tolower($0) ~ /cluster version/ {print $4;}')
kubeadm_version=$(echo "${upgrade_plan}" | awk 'tolower($0) ~ /kubeadm version/ {sub(/^v/, "", $4);print $4;}')

if [[ -z "${cluster_version}" ]] || [[ -z "${kubeadm_version}" ]] ; then
    echo "Cannot identify current and destination version, exiting ..." >&2
    exit 2
fi

if  $(verlt "${cluster_version}" "${kubeadm_version}") ; then
    echo "Cluster upgrade needed, '${cluster_version}' can be upgraded to '${kubeadm_version}'"
    kubeadm upgrade apply --yes v${kubeadm_version}
    sleep 5
    systemctl restart kubelet
else
    echo No upgrade needed
fi

echo -e"\n## Managing controlplane schedulability"
## Defautl is not schedulable
worker_nodes_count=$(kubectl get --no-headers  node | grep -v control-plane | wc -l)
## Remove taint if only ctplane node is in cluster to allow upgrade plan computation
if [[ "${KUBERNETES_SCHEDULABLE_CONTROLPLANE}" == "True" ]]  || [[ "${worker_nodes_count}" -eq 0 ]] ; then
    kubectl taint nodes "${KUBERNETES_NODE_NAME}" node-role.kubernetes.io/control-plane- || echo Control plane is already schedulable.
fi

## Remove label node.kubernetes.io/exclude-from-external-load-balancers automatically set by kubeadm that prevents metallb from working
if [[ -n "$(kubectl get node $(hostname) -o jsonpath='{.metadata.labels}' | grep node.kubernetes.io/exclude-from-external-load-balancers)" ]] ; then
    kubectl label node $(hostname) node.kubernetes.io/exclude-from-external-load-balancers-
fi

# apply node configuration
kubectl apply --server-side -f /etc/kubernetes/fedora-kube.d/kube-node-customisation.yaml

## Expose etcd metrics
if ! grep -q 'listen-metrics-urls=http://0.0.0.0:2381' /etc/kubernetes/manifests/etcd.yaml; then
  sed -i 's|listen-metrics-urls=http://127.0.0.1:2381|listen-metrics-urls=http://0.0.0.0:2381|' /etc/kubernetes/manifests/etcd.yaml
fi