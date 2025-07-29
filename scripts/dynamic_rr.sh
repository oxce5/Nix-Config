#!/usr/bin/env bash
set -euo pipefail

MONITOR="eDP-1"
WIDTH=1920
HEIGHT=1080

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <refresh_rate>"
  exit 1
fi

RATE="$1"

case "$RATE" in
  60|144) ;;
  *)
    echo "Unsupported refresh rate: $RATE"
    exit 2
    ;;
esac

# Use full path to hyprctl for reliability on NixOS with systemd
HYPRCTL="/run/current-system/sw/bin/hyprctl"

exec "$HYPRCTL" keyword monitor "$MONITOR,${WIDTH}x${HEIGHT}@${RATE},auto,1"
