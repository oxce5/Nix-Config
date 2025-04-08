{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # ./example.nix - add your modules here
    ./aagl.nix
  ];

  environment.systemPackages = with pkgs; [
    inputs.jerry.packages.${pkgs.system}.default
    waydroid-helper
    cloudflare-warp
    alejandra
    bat
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];

  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    open = false;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
  services = {
    thermald.enable = true;
    deluge = {
      enable = true;
      web.enable = true;
      user = "oxce5";
    };

    flatpak.enable = true;
  };
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  systemd.packages = [pkgs.cloudflare-warp]; # for warp-cli
  systemd.targets.multi-user.wants = ["warp-svc.service"]; # causes warp-svc to be started automatically
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  nix.settings = {
    substituters = ["https://ezkea.cachix.org"];
    trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
  };
  virtualisation.waydroid.enable = true;
}
