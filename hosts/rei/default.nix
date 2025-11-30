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
      ghostty
    ];
    # primaryDisplay = config.unify.hosts.nixos.rei.displays.eDP-1;
    primaryUser = "adachi";
    primaryWallpaper = builtins.fetchurl {
      url = "https://static.zerochan.net/Adachi.Rei.full.3685990.jpg";
      sha256 = "sha256-grmog1BGo1x1rjNoUXQMNlWXdfi/ZxZ7cASZIZt9R4k=";
    };
    baseImage = builtins.fetchurl {
      url = "https://s3.zerochan.net/Adachi.Rei.240.3683316.jpg";
      sha256 = "sha256-oxc+99D+3i2yPq1vq7UdI1kNC87V4CDhwKRNc1SbLEs=";
    };

    users.adachi.modules = config.unify.hosts.nixos.rei.modules;

    nixos = {
      pkgs,
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

      boot.kernelPackages = pkgs.linuxPackages_zen;

      networking = {
        networkmanager.enable = true;
        firewall.enable = false;
        hostName = "rei";
      };

      environment.systemPackages = [pkgs.uv pkgs.neovim pkgs.openvpn pkgs.brave];

      environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
    };
  };
}
