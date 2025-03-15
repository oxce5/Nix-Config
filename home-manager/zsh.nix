{
 programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      # Launch Hyprland on tty1 if not already in Wayland
      export EDITOR=nvim

      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        Hyprland
      fi

      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.omp.json)"
    '';    

    shellAliases = {
      ls = "lsd";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      update = "sudo nixos-rebuild switch --flake /home/oxce5/nix-config/";
      home-update = "home-manager switch --flake /home/oxce5/nix-config/";
      mux_def = "~/nix-config/assets/load_layout.sh";
    };
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "zsh-lsd"
        "git"
        "sudo"
        "z"
      ];
    };
  };
}
