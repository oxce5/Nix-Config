{
  unify = {
    modules.server.nixos = {hostConfig, ...}: {
      users.users.${hostConfig.primaryUser}.linger = true;
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
