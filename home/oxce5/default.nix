{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    inputs.zen-browser.homeModules.twilight
    inputs.impermanence.homeManagerModules.impermanence
    outputs.nixosModules.mutable
    outputs.homeManagerModules.oxce5-dots
    outputs.homeManagerModules.oxce5_niri

    ./packages.nix
    ./programs.nix
    ./services.nix
  ];

  stylix = {
    targets = {
      blender.enable = true;
      cava = {
        enable = true; 
        rainbow.enable = true;
      };
      gnome.enable = lib.mkForce false;
      vesktop.enable = true;
      fzf.enable = true;
      lazygit.enable = true;
      nvf = {
        enable = true;
        transparentBackground = true;
      };
      qt.enable =  true;
      wofi.enable = true;
      yazi.enable = true;
    };
    image = ./wallpapers/tetoes5.jpg;
    polarity = "dark";
  };

  programs.home-manager.enable = true;

  home = {
    stateVersion = "25.05";
    persistence."/persistent" = {
      directories = [
        ".zen"
      ];
      allowOther = false;
    };
    sessionVariables = {
      TERMINAL = "ghostty";
    };
  };
}
