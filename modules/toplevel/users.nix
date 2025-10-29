{
  unify = {
    modules.server.nixos = {hostConfig, ...}: {
      users.users.${hostConfig.primaryUser} = {
        linger = true;
        authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkV1+Pn73xbBHobsgg2DYgaE8T0e0ngpew50x3Silsg avg.gamer@proton.me"
        ];
      };
    };
    nixos = {
      hostConfig,
      pkgs,
      ...
    }: {
      users = {
        groups.${hostConfig.primaryUser} = {};
        users.${hostConfig.primaryUser} = {
          isNormalUser = true;
          initialPassword = hostConfig.primaryUser;
          extraGroups = [
            "wheel"
            "video"
            "audio"
            "networkmanager"
            "lp"
            "scanner"
            "docker"
            "kvm"
            "libvirtd"
            "qemu"
            "gamemode"
            "aria2"
            "keyd"
          ];
          shell = pkgs.fish;
        };
      };
    };
  };
}
