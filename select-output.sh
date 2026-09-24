#!/usr/bin/env bash
set -euo pipefail

if ! command -v pw-dump >/dev/null || ! command -v wpctl >/dev/null; then
  echo "Pulse EQ output selection requires PipeWire's pw-dump and wpctl commands." >&2
  exit 1
fi

config_home="${XDG_CONFIG_HOME:-${HOME}/.config}"
state_file="${config_home}/pulse-eq/state.json"
current_name="$(wpctl inspect @DEFAULT_AUDIO_SINK@ 2>/dev/null \
  | sed -n 's/.*node\.name = "\([^"]*\)".*/\1/p' | head -n1 || true)"

sink_id="$(pw-dump | python3 -c '
import json
import os
import sys

state_file, current_name = sys.argv[1:]
objects = json.load(sys.stdin)
nodes = [obj for obj in objects if obj.get("type") == "PipeWire:Interface:Node"]
eq = next((obj for obj in nodes if obj.get("info", {}).get("props", {}).get("node.name") == "pulse_eq_input"), None)
if not eq:
    sys.exit(3)

state = {}
try:
    with open(state_file) as stream:
        state = json.load(stream)
except (OSError, ValueError):
    pass

physical = [obj for obj in nodes
            if obj.get("info", {}).get("props", {}).get("media.class") == "Audio/Sink"
            and obj.get("info", {}).get("props", {}).get("node.name") != "pulse_eq_input"]
names = {obj.get("info", {}).get("props", {}).get("node.name") for obj in physical}
if current_name in names:
    state["hardware_sink"] = current_name
elif state.get("hardware_sink") not in names:
    physical.sort(key=lambda obj: obj.get("info", {}).get("props", {}).get("priority.session", 0), reverse=True)
    state["hardware_sink"] = physical[0].get("info", {}).get("props", {}).get("node.name") if physical else None

if state.get("hardware_sink"):
    os.makedirs(os.path.dirname(state_file), exist_ok=True)
    with open(state_file, "w") as stream:
        json.dump(state, stream, indent=2)
print(eq["id"])
' "$state_file" "$current_name")"

if [[ -z "$sink_id" ]]; then
  echo "Pulse EQ is not loaded, or no hardware output is available. Apply the EQ in the app first." >&2
  exit 1
fi

wpctl set-default "$sink_id"
echo "Pulse EQ is now the default audio output."
