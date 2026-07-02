#!/bin/bash
set -euo pipefail

# Keep /etc/kubernetes/tmp from filling /var (kubeadm etcd backups are ~500 MiB each).
# Retains only the newest entry per backup category.

KUBEADM_TMP=/etc/kubernetes/tmp

CATEGORIES=(
  'kubeadm-backup-etcd-*'
  'kubeadm-backup-manifests-*'
  'kubeadm-kubelet-config*'
  'kubeadm-kubelet-env*'
  'kubeadm-upgraded-manifests*'
)

log() {
  echo "$*"
  logger -t kubeadm-tmp-cleanup "$*"
}

keep_newest_only() {
  local pattern=$1
  local -a matches=()

  shopt -s nullglob
  matches=( "$KUBEADM_TMP"/$pattern )
  shopt -u nullglob

  if (( ${#matches[@]} <= 1 )); then
    return 0
  fi

  mapfile -t sorted < <(ls -1dt "${matches[@]}")
  local keep=${sorted[0]}
  local entry

  for entry in "${sorted[@]:1}"; do
    rm -rf "$entry"
    log "removed $(basename "$entry") (kept $(basename "$keep"))"
  done
}

[[ -d $KUBEADM_TMP ]] || exit 0

log "starting ($(find "$KUBEADM_TMP" -mindepth 1 -maxdepth 1 | wc -l) entries)"
for pattern in "${CATEGORIES[@]}"; do
  keep_newest_only "$pattern"
done
log "done ($(du -sh "$KUBEADM_TMP" | cut -f1))"
