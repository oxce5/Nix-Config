{
  inputs,
  config,
  ...
}: {
  unify.hosts.nixos.rei = {
    modules = with config.unify.modules; [
      hacking
      hyprland
      ssh
      zellij
      stylix
    ];
    # primaryDisplay = config.unify.hosts.nixos.rei.displays.eDP-1;
    primaryUser = "adachi";
    primaryWallpaper = builtins.fetchurl {
      url = "https://img2.gelbooru.com/images/02/ec/02ecefa2b0264715119bdae475a1b5fb.jpg";
      sha256 = "sha256-/oh8KKZtxdP71kducSQIr23dpW7XZ2P8WpMsCqLuIlE=";
    };
    baseImage = builtins.fetchurl {
      url = "https://s3.zerochan.net/Adachi.Rei.240.3683316.jpg";
      sha256 = "sha256-oxc+99D+3i2yPq1vq7UdI1kNC87V4CDhwKRNc1SbLEs=";
    };

    users.adachi.modules = config.unify.hosts.nixos.rei.modules;

    nixos = {
      pkgs,
      lib,
      hostConfig,
      ...
    }: {
      facter.reportPath = ./facter.json;
      imports = with inputs; [
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        nixos-hardware.nixosModules.common-pc-ssd

        nix-flatpak.nixosModules.nix-flatpak
        stylix.nixosModules.stylix
        chaotic.nixosModules.default
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_zen;
        loader = {
          timeout = lib.mkForce 0;
          systemd-boot.configurationLimit = 1;
        };
      };
      nix.settings = {
        keep-derivations = lib.mkForce false;
        keep-outputs = lib.mkForce false;
      };

      networking = {
        networkmanager.enable = true;
        firewall.enable = false;
        hostName = "rei";
      };

      environment.systemPackages = [pkgs.uv pkgs.neovim pkgs.openvpn pkgs.brave pkgs.kitty];

      environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
    };
  };
}
