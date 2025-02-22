# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    inputs.spicetify-nix.homeManagerModules.default
   # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
          };
        }; 
    }; 
  };
  

  # TODO: Set your username
  home = {
    username = "oxce5";
    homeDirectory = "/home/oxce5";
  };

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  programs.yazi.enable = true;
  programs.obs-studio.enable = true;
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      # Launch Hyprland on tty1 if not already in Wayland
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        Hyprland
      fi
    '';    

    shellAliases = {
      ls = "lsd";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      update = "sudo nixos-rebuild switch";
      home-update = "home-manager switch";
    };
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "zsh-lsd"
        "git"
        "sudo"
        "z"
      ];
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "craver";  
  };
  
  programs.cava = {
      enable = true;
      settings = {
        input.method = "pipewire";
    };
  };
  
  programs.hyprlock = {
    enable = true;
    extraConfig = "source=~/.config/hypr/hyprlock/hyprlock.conf";
  };

  services.hypridle = {
    enable = true;
    settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "pidof hyprlock || hyprlock";
          ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "hyprlock";
          on-resume = "notify-send 'Welcome back!'";
        }
        {
          timeout = 240;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.playerctld.enable = true;

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    discord
    krita
    betterdiscordctl
    fastfetch
    grimblast
    mpv
    ani-cli
    libreoffice
    blender
    tealdeer
    heroic
    davinci-resolve
    clinfo
    telegram-desktop
    obsidian
    playerctl
    libnotify

    # Hyprland packages
    waybar
    swww
    rofi
    dunst 
    swaybg
    swaylock
    swayidle
    pamixer
    light
    brillo
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  #catppuccin = {
  #  enable = true;
  #  flavor = "mocha";
  #  accent = "blue";
  #};

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
