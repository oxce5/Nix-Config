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

      spf() {
        export SPF_LAST_DIR="/home/oxce5/.local/state/superfile/lastdir"
        
        command spf "$@"

        [ ! -f "$SPF_LAST_DIR" ] || {
            bash "$SPF_LAST_DIR"
            rm -f -- "$SPF_LAST_DIR" > /dev/null
        }
      }
    '';    

    shellAliases = {
      ls = "lsd";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      update = "sudo nixos-rebuild switch";
      home-update = "home-manager switch";
      spf = "superfile";
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
