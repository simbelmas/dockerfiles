#!/bin/bash
# Apply hardware- or board-specific rpm-ostree kernel arguments, then reboot if a new
# deployment was staged (avoids leaving the node with a pending karg change).
#
# Extend by adding profiles in detect_profile() and apply_<profile>() below.
set -euo pipefail

LOG_TAG=bootc-node-kargs
log() { logger -t "$LOG_TAG" -- "$*" || true; echo "[$LOG_TAG] $*"; }

has_intel_display() {
  local d vendor class
  for d in /sys/bus/pci/devices/*; do
    [[ -r "$d/vendor" && -r "$d/class" ]] || continue
    vendor=$(cat "$d/vendor")
    class=$(cat "$d/class")
    if [[ "$vendor" == "0x8086" && "$class" =~ ^0x03 ]]; then
      return 0
    fi
  done
  return 1
}

# Example: ASUS TUF Gaming B650M-PLUS WiFi (AM5, AMD B650) — Amazon ref B0BHHVLN34
# DMI strings vary by BIOS; adjust board_name match if yours differs.
match_asus_tuf_b650m_plus_wifi() {
  local vendor name
  vendor=$(tr '[:upper:]' '[:lower:]' < /sys/class/dmi/id/board_vendor 2>/dev/null || true)
  name=$(tr '[:upper:]' '[:lower:]' < /sys/class/dmi/id/board_name 2>/dev/null || true)
  [[ "$vendor" == *asus* ]] && [[ "$name" == *b650m* ]] && [[ "$name" == *plus* ]]
}

detect_profile() {
  case "$(uname -m)" in
    x86_64) ;;
    aarch64)
      log "aarch64: no profile wired yet; add apply_arm_* and return"
      echo ""
      return 0
      ;;
    *)
      log "unsupported arch $(uname -m); skipping"
      echo ""
      return 0
      ;;
  esac

  if has_intel_display; then
    echo intel_i915_huc
    return 0
  fi
  if match_asus_tuf_b650m_plus_wifi; then
    echo amd_am5_b650_placeholder
    return 0
  fi
  echo ""
}

apply_intel_i915_huc() {
  log "profile intel_i915_huc: append i915.enable_guc=2 (GuC+HuC for Intel video)"
  rpm-ostree kargs --append-if-missing=i915.enable_guc=2
}

apply_amd_am5_b650_placeholder() {
  log "profile amd_am5_b650_placeholder: ASUS TUF B650M-PLUS class board — add real kargs when needed"
  # PLACEHOLDER: no kargs appended by default (safe on AM5 + B650).
  # Examples you might enable later after validation:
  # rpm-ostree kargs --append-if-missing=amdgpu.runpm=0
  # rpm-ostree kargs --append-if-missing=amdgpu.aspm=0
  :
}

staged_deployment_pending() {
  local json
  json=$(rpm-ostree status --json 2>/dev/null) || return 1
  if command -v jq >/dev/null 2>&1; then
    echo "$json" | jq -e '.deployments[] | select(.staged == true)' >/dev/null 2>&1
    return $?
  fi
  echo "$json" | grep -qE '"staged"[[:space:]]*:[[:space:]]*true'
}

main() {
  if ! command -v rpm-ostree >/dev/null 2>&1; then
    log "rpm-ostree not found; skipping (not an ostree image?)"
    exit 0
  fi

  local profile
  profile=$(detect_profile)
  if [[ -z "$profile" ]]; then
    log "no matching hardware profile; nothing to do"
    exit 0
  fi
  log "selected profile: $profile"

  case "$profile" in
    intel_i915_huc) apply_intel_i915_huc ;;
    amd_am5_b650_placeholder) apply_amd_am5_b650_placeholder ;;
    *)
      log "unknown profile $profile"
      exit 1
      ;;
  esac

  if staged_deployment_pending; then
    log "staged deployment present after kargs — rebooting to apply kernel arguments"
    # Immediate reboot so the node does not run with a pending/inconsistent ostree state.
    systemctl reboot
  else
    log "no staged deployment; reboot not needed"
  fi
}

main "$@"
