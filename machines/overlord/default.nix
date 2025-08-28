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
    outputs.nixosModules.berkeley-mono
    inputs.niri.nixosModules.niri

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

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  home-manager.users.oxce5 = import ../../home/oxce5;

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs = { 
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    }; 
  };


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
  boot.kernelPackages = pkgs.linuxPackages_zen;


  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://hyprland.cachix.org"
      "https://ezkea.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://prismlauncher.cachix.org"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:vliehR4ZkL9QFXy3yF3XYxkq8vA2BNB8+HF9zGml8Xg="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  networking.hostName = "overlord";
  system.stateVersion = "25.05";

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
	  prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
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
  dbus.packages = [ pkgs.nautilus ];
  };
}
