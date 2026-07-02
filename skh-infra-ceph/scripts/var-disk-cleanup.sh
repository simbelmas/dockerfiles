#!/bin/bash
set -euo pipefail

# Keep the small /var partition (~10 GiB on FCOS) from filling up.
# Runs coredump cleanup, ceph log trimming, and other /var clutter removal.

COREDUMP_DIR=/var/lib/systemd/coredump
COREDUMP_MAX_MB=100
COREDUMP_MAX_AGE_DAYS=7

CEPH_LOG_DIR=/var/log/ceph
CEPH_VOLUME_LOG_MAX_MB=100
CEPH_LOG_ROTATED_MAX_AGE_DAYS=14

log() {
  echo "$*"
  logger -t var-disk-cleanup "$*"
}

var_free() {
  df -h /var | awk 'NR==2 {print $4}'
}

cleanup_coredumps() {
  [[ -d $COREDUMP_DIR ]] || return 0

  find "$COREDUMP_DIR" -type f -mtime +"$COREDUMP_MAX_AGE_DAYS" -delete 2>/dev/null || true

  while [[ $(du -sm "$COREDUMP_DIR" | cut -f1) -gt $COREDUMP_MAX_MB ]]; do
    oldest=$(ls -tr "$COREDUMP_DIR" 2>/dev/null | head -1)
    [[ -n $oldest ]] || break
    rm -f "$COREDUMP_DIR/$oldest"
  done

  log "coredumps: $(du -sh "$COREDUMP_DIR" | cut -f1) (cap ${COREDUMP_MAX_MB} MiB, max age ${COREDUMP_MAX_AGE_DAYS}d)"
}

cleanup_ceph_removed_stores() {
  for removed in /var/lib/ceph/*/removed; do
    [[ -d $removed ]] || continue

    count=0
    for store in "$removed"/mon.*; do
      [[ -d $store ]] || continue
      rm -rf "$store"
      count=$((count + 1))
    done

    if [[ $count -gt 0 ]]; then
      log "ceph removed: deleted $count old mon store(s) from $removed"
    fi
  done
}

cleanup_ceph_logs() {
  [[ -d $CEPH_LOG_DIR ]] || return 0

  local keep_bytes=$(( CEPH_VOLUME_LOG_MAX_MB * 1024 * 1024 ))
  local logfile size_mb

  while IFS= read -r -d '' logfile; do
    size_mb=$(du -m "$logfile" | cut -f1)
    if [[ $size_mb -gt $CEPH_VOLUME_LOG_MAX_MB ]]; then
      tail -c "$keep_bytes" "$logfile" > "${logfile}.tmp"
      mv -f "${logfile}.tmp" "$logfile"
      log "ceph log: trimmed ${logfile} to ${CEPH_VOLUME_LOG_MAX_MB} MiB (was ${size_mb} MiB)"
    fi
  done < <(find "$CEPH_LOG_DIR" -name 'ceph-volume.log' -type f -print0 2>/dev/null)

  find "$CEPH_LOG_DIR" -type f \( -name '*.log-*' -o -name '*.gz' \) \
    -mtime +"$CEPH_LOG_ROTATED_MAX_AGE_DAYS" -delete 2>/dev/null || true

  log "ceph logs: $(du -sh "$CEPH_LOG_DIR" | cut -f1) (ceph-volume.log cap ${CEPH_VOLUME_LOG_MAX_MB} MiB)"
}

log "starting (/var free: $(var_free))"
cleanup_coredumps
cleanup_ceph_removed_stores
cleanup_ceph_logs
log "done (/var free: $(var_free))"
