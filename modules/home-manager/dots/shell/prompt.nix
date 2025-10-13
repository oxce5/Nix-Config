{pkgs, ...}: let
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
  programs.starship =
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
}
