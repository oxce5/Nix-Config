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
    };
  } // enableIntegrations [ "Bash" "Zsh" "Fish" ];
}
