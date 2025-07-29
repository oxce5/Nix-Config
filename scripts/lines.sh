#!/usr/bin/env bash
# Usage: ./pick-random-line.sh /path/to/file.txt

set -euo pipefail

FILE="${1:-}"

if [[ -z "$FILE" || ! -f "$FILE" ]]; then
  echo "Usage: $0 /path/to/file.txt" >&2
  exit 1
fi

shuf -n1 "$FILE"
