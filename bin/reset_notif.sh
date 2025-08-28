#!/usr/bin/env bash

notify-send "Restarting Bar and Mako..."
prog1="mako"
prog2="kurukurubar"
pkill -x "$prog1"
systemctl --user stop mako.service
pkill -x "quickshell"
sleep 1
"$prog1" &
systemctl --user restart mako.service
sleep 0.25
"$prog2" &
notify-send "Bar and Mako restarted."
