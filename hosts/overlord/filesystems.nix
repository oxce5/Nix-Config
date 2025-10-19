{
  unify.hosts.nixos.overlord = {
    nixos = {
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/5768cdb0-f45a-46a6-9802-738595c7e079";
        fsType = "ext4";
      };
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1A3A-626E";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
    };
  };
}
