{
  unify = {
    nixos = {
      pkgs,
      hostConfig,
      ...
    }: {
      users.users = {
        ${hostConfig.primaryUser} = {
          isNormalUser = true;
          shell = pkgs.fish;
          extraGroups = [
            "wheel"
            "video"
            "audio"
            "networkmanager"
          ];
        };
        # sillytavern = {
        #   home = "/var/lib/sillytavern";
        #   group = "sillytavern";
        #   isSystemUser = true;
        # };
      };
      users.groups.sillytavern = {};
    };
    modules = {
      server.nixos = {hostConfig, ...}: {
        users.users.${hostConfig.primaryUser} = {
          linger = true;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkV1+Pn73xbBHobsgg2DYgaE8T0e0ngpew50x3Silsg avg.gamer@proton.me"
          ];
        };
      };

      # sillytavern.nixos = {
      #   users = {
      #     users.sillytavern = {
      #       linger = true;
      #     };
      #   };
      # };

      laptop.nixos = {hostConfig, ...}: {
        users = {
          groups.${hostConfig.primaryUser} = {};
          users.${hostConfig.primaryUser} = {
            initialPassword = hostConfig.primaryUser;
            extraGroups = [
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
          };
        };
      };
    };
  };
}
