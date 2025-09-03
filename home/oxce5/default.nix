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
      vencord.enable = true;
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
    image = ./tetoes4.jpg;
  };

  programs.home-manager.enable = true;

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/roblox-player" = "org.vinegarhq.Sober.desktop";
      };
    };
    portal = lib.mkForce {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
    };
  };

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
