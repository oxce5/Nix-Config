#!/bin/zsh

tmux new-session -d -s main -c ~/nix-config                # Start session in ~/nix-config
tmux split-window -h -c ~/nix-config 'zsh -i -c "eval yy"'      # Split horizontally, run yy on right
tmux split-window -v -t main:0.0 -c ~/nix-config           # Split left pane vertically
tmux send-keys -t main:0.0 'lazygit' C-m                   # Run lazygit in top-left pane
tmux attach-session -t main                                # Attach to session
