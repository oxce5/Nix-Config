#!/bin/zsh

MON="eDP-1"
RES="1920x1080"

for dir in /run/user/*; do
  for hypr_dir in "$dir/hypr/"*/; do
    socket="${hypr_dir}.socket.sock"
    if [[ -S $socket ]]; then
      echo -e "keyword monitor $MON,$RES@$1,1" | socat - UNIX-CONNECT:"$socket"
    fi
  done
done
