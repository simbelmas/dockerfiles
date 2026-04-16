#!/bin/zsh

set -e

kubeadm_config_file=/etc/kubernetes/kubeadm-join.yaml

source /usr/local/lib/shell_utilities_functions.zsh
source /etc/kubernetes/fedora-kube.d/*.conf

echo -e "\n\n\n### Starting kubernetes worker node lifecycle management service"

## Preflight checks
if [[ ! -f "${kubeadm_config_file}" ]] ; then
    echo "Kubeadm config file '${kubeadm_config_file}' does not exists, exiting" >&2
    exit 1
fi

echo -e "## Validating kubeadm configuration"
kubeadm config validate --config ${kubeadm_config_file}

echo -e "\n##Managing Node join"
attempt=1

while [[ "${attempt}" -le 120 ]] ; do
    echo "Waiting cluster apiserver availability (${attempt}/120)"
    if curl -svk --connect-timeout 2 --max-time 5 "https://${KUBERNETES_API_ENDPOINT}:6443" 2>/dev/null 1>&2 ; then
        break
    fi
    attempt=$(( attempt + 1 ))
    sleep 5
done

if [[ ! -f /var/lib/kubelet/config.yaml ]] ; then
    kubeadm join --config "${kubeadm_config_file}"
else
    echo "Node already joined a cluster, continue ..."
fi

## Runnning unconditional upgrade, it's idempotent
package_version=$(kubectl version | awk 'tolower($0) ~ /client version/ {sub(/^v/, "", $3); print $3;}')
running_version=$(kubectl get node $(hostname) -o jsonpath='{.status.nodeInfo.kubeletVersion}' | tr -d v)
server_version=$(kubectl version | awk 'tolower($0) ~ /server version/ {sub(/^v/, "", $3); print $3;}')
if [ -z "${package_version}" ] ; then
    echo "Cannot determine package version, exiting ..." >&2
    exit 2
fi
if [ -z "${running_version}" ] ; then
    echo "Cannot determine running version, exiting ..." >&2
    exit 2
fi
if [ -z "${server_version}" ] ; then
    echo "Cannot determine server version, exiting ..." >&2
    exit 2
fi
if $(verlt "${running_version}" "${package_version}") && $(verlte "${package_version}" "${server_version}") ; then
    echo "Worker node upgrade needed, proceeding ..."
    kubeadm upgrade node
    systemctl daemon-reload
    systemctl restart kubelet
else
    echo "No Worker node upgrade needed, continue ..."
    if $(verlte "${package_version}" "${server_version}") ; then
        echo "[WARNING] worker version is higher than control plane."
    fi
fi

## Remove label node.kubernetes.io/exclude-from-external-load-balancers automatically set by kubeadm that prevents metallb from working
if [[ -n "$(kubectl get node $(hostname) -o jsonpath='{.metadata.labels}' | grep node.kubernetes.io/exclude-from-external-load-balancers)" ]] ; then
    kubectl label node $(hostname) node.kubernetes.io/exclude-from-external-load-balancers-
fi

# apply node configuration
if ! kubectl apply --server-side -f /etc/kubernetes/fedora-kube.d/kube-node-customisation.yaml ; then
    echo "Error applying node definition, exiting"
    exit 1
fi

echo "Worker node configuration done."