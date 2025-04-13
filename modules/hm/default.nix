{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # ./example.nix - add your modules here
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index

    ./nvf_config.nix
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      marketplace
    ];
  };
  programs.yazi.enable = true;
  programs.lazygit.enable = true;

  # home-manager options go here/
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    krita
    clang
    mpv
    tealdeer
    blender
    motrix
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];
  home.file = {
    ".config/hypr/userprefs.conf" = lib.mkForce {
      source = ./config/userprefs.conf;
      force = true;
      mutable = true;
    };
    ".config/hypr/keybindings.conf" = lib.mkForce {
      source = ./config/keybindings.conf;
      force = true;
      mutable = true;
    };
    "${config.xdg.configHome}/mimeapps.list".force = lib.mkForce true;
  };
  services.podman.enable = true;

  # hydenix home-manager options go here
  hydenix.hm = {
    #! Important options
    enable = true;

    /*
    ! Below are defaults
    */
    comma.enable = true; # useful nix tool to run software without installing it first
    dolphin.enable = true; # file manager
    editors = {
      enable = true; # enable editors module
      vscode = {
        enable = false; # enable vscode module
        wallbash = true; # enable wallbash extension for vscode
      };
      default = "nvim"; # default text editor
    };

    fastfetch.enable = true; # fastfetch configuration
    firefox = {
      enable = false; # enable firefox module
      useHydeConfig = false; # use hyde firefo configuration and extensions
      useUserChrome = true; # if useHydeConfig is true, apply hyde userChrome CSS customizations
      useUserJs = true; # if useHydeConfig is true, apply hyde user.js preferences
      useExtensions = true; # if useHydeConfig is true, install hyde firefox extensions
    };
    git = {
      enable = true; # enable git module
      name = "oxce5"; # git user name eg "John Doe"
      email = "avg.gamer@proton.me"; # git user email eg "john.doe@example.com"
    };
    hyde.enable = true; # enable hyde module
    hyprland.enable = true; # enable hyprland module
    lockscreen = {
      enable = true; # enable lockscreen module
      hyprlock = true; # enable hyprlock lockscreen
      swaylock = false; # enable swaylock lockscreen
    };
    notifications.enable = true; # enable notifications module
    qt.enable = true; # enable qt module
    rofi.enable = true; # enable rofi module
    screenshots = {
      enable = true; # enable screenshots module
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = true; # enable satty screenshot annotation tool
      swappy.enable = false; # enable swappy screenshot editor
    };
    shell = {
      enable = true; # enable shell module
      zsh.enable = true; # enable zsh shell
      zsh.configText = ''
        alias rebuild="/home/oxce5/hydenix/scripts/nixos-rebuild.sh"
      ''; # zsh config text
      bash.enable = false; # enable bash shell
      fish.enable = false; # enable fish shell
      pokego.enable = true; # enable Pokemon ASCII art scripts
    };
    social = {
      enable = true; # enable social module
      discord.enable = true; # enable discord module
      webcord.enable = false; # enable webcord module
      vesktop.enable = false; # enable vesktop module
    };
    spotify.enable = false; # enable spotify module
    swww.enable = true; # enable swww wallpaper daemon
    terminals = {
      enable = true; # enable terminals module
      kitty.enable = true; # enable kitty terminal
      kitty.configText = ""; # kitty config text
    };
    theme = {
      enable = true; # enable theme module
      active = "Tokyo Night"; # active theme name
      themes = [
        "Tokyo Night"
      ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
    };
    waybar.enable = true; # enable waybar module
    wlogout.enable = true; # enable wlogout module
    xdg.enable = true; # enable xdg module
  };
}
