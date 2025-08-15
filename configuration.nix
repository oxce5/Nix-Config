{
  inputs,
  config,
  ...
}: let
  # Package declaration
  # ---------------------
  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    config.packageOverrides = pkgs: {
      obs-studio = pkgs.obs-studio.override {ffmpeg = pkgs.ffmpeg-full;};
    };
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        unstable = import inputs.nixpkgs {
          system = prev.system;
          config.allowUnfree = true;
        };
        nh = inputs.nixpkgs.legacyPackages.${prev.system}.nh;
        blender = inputs.nixpkgs.legacyPackages.${prev.system}.blender;
      })
      (import ./modules/overlays/youtube-music_master.nix)
    ];
  };
in {
  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;
  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    inputs.hydenix.lib.nixOsModules
    ./modules/system

    # === GPU-specific configurations ===
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    inputs.nixos-hardware.nixosModules.common-cpu-intel

    # === Other common modules ===
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    #! EDIT THIS USER (must match users defined below)
    users."oxce5" = {...}: {
      imports = [
        inputs.hydenix.lib.homeModules
        ./modules/hm
      ];
    };
  };

  # IMPORTANT: Customize the following values to match your preferences
  hydenix = {
    enable = true; # Enable the Hydenix module

    #! EDIT THESE VALUES
    hostname = "hydenix"; # Change to your preferred hostname
    timezone = "Asia/Manila"; # Change to your timezone
    locale = "en_PH.UTF-8"; # Change to your preferred locale

    audio.enable = true; # enable audio module
    boot = {
      enable = true; # enable boot module
      useSystemdBoot = false; # disable for GRUBcpufreq
      grubTheme = "Retroboot"; # or pkgs.hydenix.grub-pochita
      grubExtraConfig = ""; # additional GRUB configuration
      kernelPackages = pkgs.linuxPackages_zen; # default zen kernel
    };
    gaming.enable = false;
    hardware.enable = true; # enable hardware module
    network.enable = true; # enable network module
    nix.enable = true; # enable nix module
    sddm = {
      enable = true; # enable sddm module
      theme = "Candy"; # or pkgs.hydenix.sddm-corners
    };
    system.enable = true; # enable system module
  };

  #! EDIT THESE VALUES (must match users defined above)
  users.users.oxce5 = {
    isNormalUser = true; # Regular user account
    initialPassword = "hydenix"; # Default password (CHANGE THIS after first login with passwd)
    extraGroups = [
      "wheel" # For sudo access
      "networkmanager" # For network management
      "video" # For display/graphics access
      "docker"
      "scanner"
      "lp"
      "gamemode"
      "adbusers"
      "aria"
      # Add other groups as needed
    ];
    shell = pkgs.zsh; # Change if you prefer a different shell
  };
  security.sudo.extraRules = [
    {
      users = ["oxce5"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];
  security.polkit.enable = true;

  boot = {
    loader = {
      timeout = 5;
      systemd-boot.configurationLimit = 3;
      grub.configurationLimit = 3;
    };
    kernelModules = [
      "msr"
      "ntsync"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      lenovo-legion-module
    ];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    plymouth = {
      enable = true;
    };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://ezkea.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://prismlauncher.cachix.org"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:vliehR4ZkL9QFXy3yF3XYxkq8vA2BNB8+HF9zGml8Xg="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };
  documentation.nixos.enable = false;
}
