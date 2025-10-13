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
    # inputs.impermanence.homeManagerModules.impermanence
    outputs.nixosModules.mutable
    outputs.homeManagerModules.oxce5_dots
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
      qt.enable = true;
      wofi.enable = true;
      yazi.enable = true;
      zellij.enable = true;
    };
    image = ./wallpapers/KASANE_TETO.png;
    polarity = "dark";
  };

  dots = {
    bar = "noctalia";
    cursor = "teto_cursor";
    ghostty = true;
    nvim = true;
    shells = {
      enableZsh = true;
      enableBash = true;
      enableFish = true;
    };
    yazi = true;
  };

  programs.home-manager.enable = true;
  programs.nix-index-database.comma.enable = true;

  home = {
    stateVersion = "25.05";
    sessionVariables = {
      TERMINAL = "ghostty";
    };
  };

  xdg.mimeApps = let
    value = let
      zen-browser = inputs.zen-browser.packages.${pkgs.system}.twilight; # or twilight
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (map (name: {
        inherit name value;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
