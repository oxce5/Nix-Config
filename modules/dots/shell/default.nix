{pkgs, ...}: let
  tokyoNight = builtins.fromTOML (builtins.readFile (pkgs.fetchurl {
    url = "https://starship.rs/presets/toml/tokyo-night.toml";
    sha256 = "0cdvypfxnfjvlcvnxb3dgq0pcsbp81ddapcfji0lvwrxdxaja8kr";
  }));
in {
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh.shellAliases = {
      cd = "z";
      nos = "rm -f ~/.Xresources.backup && alejandra ~/hydenix && nh os switch";
    };
    bash.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
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
