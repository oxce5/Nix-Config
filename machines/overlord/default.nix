{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.stylix.nixosModules.stylix
    # inputs.chaotic-nyx.nixosModules.default
    inputs.chaotic-nyx.nixosModules.nyx-cache
    inputs.chaotic-nyx.nixosModules.nyx-overlay
    inputs.chaotic-nyx.nixosModules.nyx-registry
    outputs.nixosModules.niri-flake
    outputs.nixosModules.berkeley-mono

    ./hardware-configuration.nix
    ../../modules/users/oxce5.nix # Includes home-manager config
    ../common/global.nix
    ../common/container.nix
    ../common/development.nix
    ../common/desktop.nix
    ../common/gaming.nix
    ../common/hardware.nix
    ../common/services.nix
    ../common/packages.nix
  ];

  home-manager = { 
   useGlobalPkgs = true;
   backupFileExtension = "backup";
   extraSpecialArgs = {inherit inputs outputs;};
   users.oxce5 = import ../../home/oxce5;
  };

  chaotic.nyx.cache.enable = true;

  boot.loader = {
    timeout = 5;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      # configurationLimit = 4;
    };
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [
    lenovo-legion-module
  ];
  # fix chaotic-nyx cache
  system.modulesTree = [ (lib.getOutput "modules" pkgs.linuxPackages_cachyos.kernel) ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true;

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://ezkea.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://prismlauncher.cachix.org"
      "https://devenv.cachix.org"
      "https://niri.cachix.org"
      "https://chaotic-nyx.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:vliehR4ZkL9QFXy3yF3XYxkq8vA2BNB8+HF9zGml8Xg="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };
  
  stylix = {
    enable = true;
    targets = {
      gtk.enable = true;
    };
    image = ./../../home/oxce5/tetoes4.jpg;
  };

  networking.hostName = "overlord";
  system.stateVersion = "25.05";

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  networking.networkmanager = {
    enable = true;
  };

  services = {
    upower.enable = true;
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.niri}/bin/niri-session";
        user = "greeter";
      };
    };
    dbus.packages = [pkgs.nautilus];
    acpid = {
      enable = true;
      acEventCommands = ''
        exec ${pkgs.bash}/bin/bash /home/oxce5/nix-setup/bin/daemons/batterydaemon.sh
      '';
    };
  };
  systemd.user.services."plugdaemon" = {
    description = "Plug in/out Daemon";
    script = ''
      BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
      POWER_STATUS=$(cat /sys/class/power_supply/ACAD/online)

      if [[ "$POWER_STATUS" -eq 1 ]]; then
        ${pkgs.libnotify}/bin/notify-send "Power is connected. Battery level: $BATTERY_LEVEL%"
      else
        ${pkgs.libnotify}/bin/notify-send "Power is disconnected. Battery level: $BATTERY_LEVEL%"
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };
  systemd.user.timers."plugdaemon" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "plugdaemon.service";
      };
  };
  xdg.portal = lib.mkForce {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
