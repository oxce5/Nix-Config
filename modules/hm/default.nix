{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  riceCursor = import ./ricecursor.nix { inherit (pkgs) stdenv; };
  # patchDesktop = pkg: appName: from: to: lib.hiPrio (
  #   pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
  #     ${pkgs.coreutils}/bin/mkdir -p $out/share/applications
  #     ${pkgs.gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
  #     '');
  # GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in
  {
  # Add the overlay to Nixpkgs
  imports = [
    ./hyde.nix # FORCE CUSTOM MANGOHUD

    # ./example.nix - add your modules here
    inputs.nix-index-database.hmModules.nix-index
    inputs.zen-browser.homeModules.twilight
    inputs.impermanence.homeManagerModules.impermanence

    ./hyprlock.nix
    ./nvf_config.nix
    ./shell.nix
    ./symlink.nix
    ./tmux.nix
    ./yazi.nix
    ./mangohud.nix
  ];

  # home-manager options go here/
  programs = { 
    lazygit.enable = true;
    gh.enable = true;
    zen-browser = {
      enable = true;
    };
    zellij = {
      enable = false;
      enableZshIntegration = true;
    };
    nh = {
      enable = true;
      clean.enable = if config.programs.nh.enable then true else false;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/hydenix/";
    };
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      installVimSyntax = true;
      settings = {
        keybind = [
          "ctrl+shift+d=close_surface"
        ];
      };
    };
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
    inputs.elyprism-launcher.packages.${pkgs.system}.default
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    riceCursor
    youtube-music
    trackma-curses
    heroic
    bottles
    lutris
    blender
    obsidian
    blender
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

  home.sessionVariables = {
    BATTERY_NOTIFY_EXECUTE_UNPLUG = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1";
    BATTERY_NOTIFY_EXECUTE_DISCHARGING = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1";
    BATTERY_NOTIFY_EXECUTE_CHARGING = "hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1";
    TERMINAL = "ghostty";
};
  #  home.pointerCursor= {
  #   package = riceCursor;
  #   name = "RiceShower";
  # };
  
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
    hyde.enable = false; # enable hyde module
    hyprland = {
      enable = true; # enable hyprland module
      extraConfig = ''
      $TERMINAL = ghostty
      $env.BATTERY_NOTIFY_EXECUTE_UNPLUG = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1"
      $env.BATTERY_NOTIFY_EXECUTE_CHARGING = "hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1"
      $env.BATTERY_NOTIFY_EXECUTE_DISCHARGING = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1"

      $CURSOR_THEME=Rice_Cursor
      $CURSOR_SIZE=24
      env = XCURSOR_THEME,Rice_Cursor
      env = XCURSOR_SIZE,24
      
      exec-once = hyprctl setcursor "Rice_Cursor" 24

      bindd = ALT_R, Control_R,toggle waybar, exec, kurukurubar 
      bindd = $mainMod, T, $d terminal emulator , exec, ghostty
      bindd = $mainMod Alt, T, $d dropdown terminal , exec, [float; move 20% 5%; size 60% 60%] ghostty

      monitor = eDP-1, 1920x1080@144, 0x0, 1

      misc {
        vfr = true
        render_unfocused_fps = 30
      }

      windowrulev2 = float, initialClass:^(Waydroid)$
      windowrulev2 = fullscreen, initialClass:^(Waydroid)$

      windowrulev2 = renderunfocused, initialClass:^(starrail)$
      windowrulev2 = renderunfocused, initialClass:^Minecraft.*$
      windowrulev2 = renderunfocused, initialClass:^steam_app_*$

      $&=override

      windowrulev2 = opacity 0.995 $& 0.995 $& 1,class:^(zen-twilight)$

      debug {
        full_cm_proto = true;
      }
      '';
    };
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
      enable = false; # enable social module
      discord.enable = false; # enable discord module
      webcord.enable = false; # enable webcord module
      vesktop.enable = false; # enable vesktop module
    };
    spotify.enable = false; # enable spotify module
    swww.enable = true; # enable swww wallpaper daemon
    terminals = {
      enable = false; # enable terminals module
      kitty.enable = false; # enable kitty terminal
      kitty.configText = "";
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
