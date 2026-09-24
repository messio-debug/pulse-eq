#!/usr/bin/env bash
set -euo pipefail

config_home="${XDG_CONFIG_HOME:-${HOME}/.config}"
filter_config="${config_home}/pipewire/pipewire.conf.d/90-pulse-eq.conf"
eq_filters="${config_home}/pulse-eq/filters.txt"

if [[ -f "$filter_config" ]]; then
  rm -- "$filter_config"
  echo "Removed PipeWire equalizer configuration."
fi

if [[ -f "$eq_filters" ]]; then
  rm -- "$eq_filters"
fi

if command -v systemctl >/dev/null 2>&1 && systemctl --user is-active --quiet pipewire.service; then
  services=(pipewire.service)
  systemctl --user is-active --quiet wireplumber.service && services+=(wireplumber.service)
  systemctl --user is-active --quiet pipewire-pulse.service && services+=(pipewire-pulse.service)
  if ! systemctl --user restart "${services[@]}"; then
    echo "Could not restart PipeWire. Restart your user audio services manually to remove the EQ output." >&2
  fi
fi

if command -v pkexec >/dev/null 2>&1; then
  pkexec pacman -R pulse-eq
elif command -v sudo >/dev/null 2>&1; then
  sudo pacman -R pulse-eq
else
  echo "Could not find pkexec or sudo. Remove the package with: pacman -R pulse-eq" >&2
  exit 1
fi

echo "Pulse EQ has been uninstalled. Saved presets remain in ${config_home}/pulse-eq/."
