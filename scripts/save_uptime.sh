#!/usr/bin/env bash

# Get the current uptime (in seconds and idle time)
uptime_value=$(cat /proc/uptime)

# Get the current date/time (optional, for timestamping)
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Save to a file
echo "$timestamp $uptime_value" >> ~/uptime_log.txt
