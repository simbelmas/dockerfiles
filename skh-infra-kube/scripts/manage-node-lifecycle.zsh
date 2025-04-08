#!/usr/bin/zsh
set -e

export $(grep -v '^#' /etc/kubernetes/fedora-kube.d/*.conf | cut -f2- -d':' | xargs)

case "${KUBERNETES_NODE_ROLE}" in
    worker)
        exec /usr/local/lib/manage_kubernetes_worker_lifecycle.zsh
    ;;
    controlplane)
        exec /usr/local/lib/manage_kubernetes_controlplane_lifecycle.sh
    ;;
    *)
    echo "KUBERNETES_NODE_ROLE var has to be woerker|ctplane"
    exit 1
    ;;
esac