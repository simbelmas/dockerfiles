#!/usr/bin/zsh
set -e

export $(grep -v '^#' /etc/kubernetes/fedora-kube.d/*.conf | cut -f2- -d':' | xargs)

echo ## Manage Environment variables
if [[ ! -d "/etc/systemd/system/bootc-fleetlock-fetch-upgrade.service.d" ]] ; then
    mkdir -p /etc/systemd/system/bootc-fleetlock-fetch-upgrade.service.d
fi
configureNodeUpgradeFleetlockGroup() {
    local group_name
    if [[ -z "$1" ]] ; then
        echo "NodeUpgradeFleetlockGroup Must be set" >&2
        return 1
    else
        group_name="$1"
    fi
    echo -e "[Service]\nEnvironment=NODE_UPGRADE_FLEETLOCK_GROUP=${group_name}" > /etc/systemd/system/bootc-fleetlock-fetch-upgrade.service.d/kube-node.conf    
    systemctl daemon-reload
}
case "${KUBERNETES_NODE_ROLE}" in
    worker)
        (
            set -x
            configureNodeUpgradeFleetlockGroup node
        )
        exec /usr/local/lib/manage_kubernetes_worker_lifecycle.zsh
    ;;
    controlplane)
        (
            set -x
            configureNodeUpgradeFleetlockGroup node
        )
        exec /usr/local/lib/manage_kubernetes_controlplane_lifecycle.sh
    ;;
    *)
    echo "KUBERNETES_NODE_ROLE var has to be worker|ctplane"
    exit 1
    ;;
esac
