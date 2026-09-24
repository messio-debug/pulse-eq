#!/usr/bin/env bash
set -euo pipefail

if ! command -v pw-dump >/dev/null || ! command -v wpctl >/dev/null; then
  echo "Pulse EQ output selection requires PipeWire's pw-dump and wpctl commands." >&2
  exit 1
fi

sink_id="$(pw-dump | python3 -c '
import json
import sys

for obj in json.load(sys.stdin):
    props = obj.get("info", {}).get("props", {})
    if props.get("node.name") == "pulse_eq_input":
        print(obj["id"])
        break
')"

if [[ -z "$sink_id" ]]; then
  echo "Pulse EQ is not loaded. Open the app and click Apply to PipeWire first." >&2
  exit 1
fi

wpctl set-default "$sink_id"
echo "Pulse EQ is now the default audio output."
