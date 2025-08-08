#!/usr/bin/env bash

UPTIME_TOTAL_FILE=~/.uptime_total
current_uptime=$(awk '{print $1}' /proc/uptime)

if [ -f "$UPTIME_TOTAL_FILE" ]; then
    previous_total=$(cat "$UPTIME_TOTAL_FILE")
else
    previous_total=0
fi

new_total=$(echo "$previous_total + $current_uptime" | bc)
echo "$new_total" > "$UPTIME_TOTAL_FILE"

