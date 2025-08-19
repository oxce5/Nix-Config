{
  inputs,
  config,
  pkgs,
  ...
}:
{
  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  imports = [
    inputs.omarchy-nix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
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
        inputs.omarchy-nix.homeManagerModules.default
        ./modules/hm
      ];
      home.stateVersion = "25.05";
    };
  };

  omarchy = {
    full_name = "oxce5";
    email_address = "avg.gamer@proton.me";
    theme = "tokyo-night";
    theme_overrides = ./wallpapers/tetoes4.jpg;
  };

  # IMPORTANT: Customize the following values to match your preferences
  networking.hostName = "overlord";
  time.timeZone = "Asia/Manila";
  i18n.defaultLocale = "en_PH.UTF-8";

  # Boot
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.extraConfig = ""; # Add GRUB config here
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Network
  networking.networkmanager.enable = true; # Enable NetworkManager

  programs.zsh.enable = true;

  # Nix
  nix.settings = {
    # Add your desired nix settings here
  };

  # SDDM
  # services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.theme = "Candy"; # Or pkgs.hydenix.sddm-corners

  # System module
  # system.enable = true; # No direct option, system config is in this file

  # You may want to add more options as needed for your system.
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
      "aria2"
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
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        configurationLimit = 3;
      };
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
  system.stateVersion = "25.05";
}
