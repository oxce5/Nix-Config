{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.dots.shells.enableZsh {
    home.packages = with pkgs; [
      zsh-vi-mode
      zsh-fzf-tab
      zsh-autopair
      zsh-nix-shell
      zsh-you-should-use
    ];
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        TERMINAL = "ghostty";
      };
      shellAliases = {
        cd = "z";
        lg = "lazygit";
        df = "duf";
      };
      initContent = ''
        zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza --color=always $realpath'
        zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'eza --color=always $realpath'
        zstyle ':fzf-tab:complete:vim:*' fzf-preview 'eza --color=always $realpath'

        if [[ "\$\{widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
              "\$\{widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
            zle -N zle-keymap-select "";
        fi

        eval "$(${pkgs.starship}/bin/starship init zsh)"

        chafa $HOME/tetoes.png --align center
        echo "You really are an idiot aren't you?"

      '';
      plugins = [
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
        {
          name = "you-should-use";
          src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
        }
        {
          name = "autopair";
          src = pkgs.zsh-autopair;
          file = "share/zsh/zsh-autopair/autopair.zsh";
        }
        {
          name = "vi-mode";
          src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
        }
        {
          name = "nix-shell";
          src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
        }
      ];
    };
  };
}
