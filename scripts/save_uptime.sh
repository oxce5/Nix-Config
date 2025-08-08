#!/usr/bin/bash

set -x
UPTIME_TOTAL_FILE=~/.uptime_total
current_uptime=$(awk '{print $1}' /proc/uptime)

# Read the previous total
if [ -f "$UPTIME_TOTAL_FILE" ]; then
    previous_total=$(cat "$UPTIME_TOTAL_FILE")
else
    previous_total=0
fi
previous_total=${previous_total:-0}
current_uptime=$(awk '{print $1}' /proc/uptime)
current_uptime=${current_uptime:-0}
new_total=$(echo "$previous_total + $current_uptime" | bc)
echo "$new_total" > "$UPTIME_TOTAL_FILE"

