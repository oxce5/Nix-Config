{pkgs, lib, ...}: 
let 
  enableIntegrations = shells:
    builtins.listToAttrs (map (sh: {
      name = "enable${sh}Integration";
      value = true;
    }) shells);
in
{
  
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix

    ./prompt.nix
  ];

  programs = {
    zoxide = {
      enable = true;
    } // enableIntegrations [ "Bash" "Zsh" "Fish" ];
    atuin = {
      enable = true;
    } // enableIntegrations [ "Bash" "Zsh" "Fish" ];
    fzf = {
      enable = true;
    } // enableIntegrations [ "Bash" "Zsh" "Fish" ];
    fd.enable = true;
    eza = {
      enable = true;
      colors = "always";
      icons = "always";
    } // enableIntegrations [ "Bash" "Zsh" "Fish" ];
  };
}
