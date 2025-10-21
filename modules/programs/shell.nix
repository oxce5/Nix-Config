{
  unify.home = {
    pkgs,
    config,
    ...
  }: let
    jetpack = builtins.fromTOML (builtins.readFile (pkgs.fetchurl {
      url = "https://starship.rs/presets/toml/jetpack.toml";
      sha256 = "0pwc642ibvjsbazb0gkkqc5sw95lbjvf82fd6crcif6biy67h8x8";
    }));

    nerd-fonts-prompt = builtins.fromTOML (builtins.readFile (pkgs.fetchurl {
      url = "https://starship.rs/presets/toml/nerd-font-symbols.toml";
      sha256 = "05yvqiycb580mnym7q8lvk1wcvpq7rc4jjqb829z3s82wcb9cmbr";
    }));

    enableIntegrations = shells:
      builtins.listToAttrs (map (sh: {
          name = "enable${sh}Integration";
          value = true;
        })
        shells);
  in {
    home.shellAliases = {
      cd = "z";
      lj = "lazyjj";
      lg = "lazygit";
      o = "xdg-open";
      mkdir = "mkdir -p";
      tree = "eza -T";
    };
    programs = {
      bash = {
        enable = true;
        enableVteIntegration = true;
        historyFile = "${config.xdg.configHome}/bash/history";
      };
      starship =
        {
          enable = true;
          settings =
            nerd-fonts-prompt
            // {
              direnv = {
                disabled = false;
              };
            };
        }
        // enableIntegrations ["Bash" "Zsh" "Fish"];
      atuin = {
        enable = true;
        flags = ["--disable-up-arrow"];
        enableFishIntegration = true;
      };
      bat = {
        enable = true;
        config.style = "plain";
        extraPackages = with pkgs.bat-extras; [
          prettybat
          batwatch
          batpipe
          batman
          batgrep
          batdiff
        ];
      };
      bottom.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      eza = {
        enable = true;
        git = true;
        icons = "auto";
        enableFishIntegration = true;
      };
      nix-your-shell.enable = true;
      skim.enable = true;
      tealdeer = {
        enable = true;
        settings.updates.auto_update = true;
      };
      zoxide.enable = true;
    };
  };
}
