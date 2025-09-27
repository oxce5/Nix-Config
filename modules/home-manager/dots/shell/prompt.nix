{ pkgs, ... }:
let
  jetpack = builtins.fromTOML (builtins.readFile (pkgs.fetchurl {    url = "https://starship.rs/presets/toml/jetpack.toml";
    sha256 = "0pwc642ibvjsbazb0gkkqc5sw95lbjvf82fd6crcif6biy67h8x8";
  }));

  enableIntegrations = shells:
    builtins.listToAttrs (map (sh: {
      name = "enable${sh}Integration";
      value = true;
    }) shells);
in 
{
  programs.starship = {
    enable = true;
    settings =
      jetpack
      // {
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
  } // enableIntegrations [ "Bash" "Zsh" "Fish" ];
}
