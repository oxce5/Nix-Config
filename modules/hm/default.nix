{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
      ${coreutils}/bin/mkdir -p $out/share/applications
      ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in
  {
  # Add the overlay to Nixpkgs
  imports = [
    # ./example.nix - add your modules here
    inputs.nix-index-database.hmModules.nix-index
    inputs.zen-browser.homeModules.twilight
    inputs.impermanence.homeManagerModules.impermanence
    inputs.zen-nebula.homeModules.default

    ./hyprlock.nix
    ./nvf_config.nix
    ./shell.nix
    ./symlink.nix
    ./spicetify.nix
    ./tmux.nix
    ./yazi.nix
  ];

  # home-manager options go here/
  programs = { 
    lazygit.enable = true;
    gh.enable = true;
    zen-browser = {
      enable = true;
    };
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
    nh = {
      enable = true;
      clean.enable = if config.programs.nh.enable then true else false;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/hydenix/";
    };
  };
  zen-nebula = {
    enable = true;
    profile = "wgi9he2k.Default Profile";
  };

  services = {
    podman.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/roblox-player" = [ "org.vinegarhq.Sober.desktop" ];
    };
  };

  home.packages = with pkgs; [
    trackma-curses
    heroic
    bottles
    blender
    (GPUOffloadApp blender "blender")
    zoxide
    krita
    clang
    mpv
    tealdeer
    motrix
    thunderbird
    proton-caller
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];
  home.persistence."/persistent" = {
    directories = [
      ".zen"
    ];
  };
  
  # hydenix home-manager options go here
  hydenix.hm = {
    #! Important options
    enable = true;

    /*
   ! Below are defaults
    */
    comma.enable = true; # useful nix tool to run software without installing it first
    dolphin.enable = false; # file manager
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
    };
    git = {
      enable = true; # enable git module
      name = "oxce5"; # git user name eg "John Doe"
      email = "avg.gamer@proton.me"; # git user email eg "john.doe@example.com"
    };
    hyde.enable = true; # enable hyde module
    hyprland.enable = true; # enable hyprland module
    lockscreen = {
      enable = false; # enable lockscreen module
      hyprlock = false; # enable hyprlock lockscreen
      swaylock = false; # enable swaylock lockscreen
    };
    notifications.enable = true; # enable notifications module
    qt.enable = true; # enable qt module
    rofi.enable = true; # enable rofi module
    screenshots = {
      enable = true; # enable screenshots module
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = false; # enable satty screenshot annotation tool
      swappy.enable = true; # enable swappy screenshot editor
    };
    shell = {
      enable = true; # enable shell module
      zsh.enable = true; # enable zsh shell
      zsh.configText = ''
        alias rebuild="/home/oxce5/hydenix/scripts/nixos-rebuild.sh"
        alias nvim="/home/oxce5/hydenix/scripts/nvim.sh"
      ''; # zsh config text
      zsh.plugins = [ "sudo" ];
      bash.enable = false; # enable bash shell
      fish.enable = false; # enable fish shell
      pokego.enable = true; # enable Pokemon ASCII art scripts
      p10k.enable = false; # enable p10k prompt
      starship.enable = true; # enable starship prompt
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
      kitty.configText = "
        background_opacity 0.4
      "; # kitty config text
    };
    theme = {
      enable = true; # enable theme module
      active = "Oxo Carbon"; # active theme name
      themes = [
        "Oxo Carbon"
        "Tokyo Night"
        "BlueSky"
      ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
    };
    waybar.enable = false; # enable waybar module
    wlogout.enable = true; # enable wlogout module
    xdg.enable = true; # enable xdg module
  };
}
