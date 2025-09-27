{pkgs, lib, ...}: let
  tokyoNight = builtins.fromTOML (builtins.readFile (pkgs.fetchurl {
    url = "https://starship.rs/presets/toml/tokyo-night.toml";
    sha256 = "0cdvypfxnfjvlcvnxb3dgq0pcsbp81ddapcfji0lvwrxdxaja8kr";
  }));
in {
  home.packages = with pkgs; [
    zsh-vi-mode
    zsh-fzf-tab
    zsh-autopair
    zsh-nix-shell
    zsh-you-should-use
  ];

  programs = {
    zsh = {
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
    bash.enable = true;


    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    fd.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      colors = "always";
      icons = "always";
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings =
        tokyoNight
        // {
          format = "[░▒▓](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory\${custom.direnv_allowed}\${custom.direnv_denied}[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nix_shell$nodejs$rust$golang$java$php$python[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)\n$character";
          direnv = {
            disabled = false;
          };
          java = {
            format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
            style = "bg:#212736";
            symbol = "";
          };
          nix_shell = {
            style = "bg:#212736";
            format = "[ via $symbol$state( ($name))](fg:#769ff0 bg:#212736)($style)";
            symbol = " ";
          };
          python = {
            format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
            style = "bg:#212736";
            symbol = "";
          };
          custom = {
            direnv_allowed = {
              description = "direnv active and allowed";
              format = "[ ](fg:#00ff00 bg:#769ff0)";
              when = "direnv status 2>/dev/null | grep -q 'Found RC allowed 0'";
            };
            direnv_denied = {
              description = "direnv active and denied";
              format = "[ ](fg:#ff0000 bg:#769ff0)";
              when = "direnv status 2>/dev/null | grep -q 'Found RC allowed 2'";
            };
          };
        };
    };
  };
}
