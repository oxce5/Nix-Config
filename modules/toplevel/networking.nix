{
  unify = {
    nixos = {
      # nixpkgs #180175
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.network.wait-online.enable = false;
    };
    modules.server.nixos.networking.tempAddresses = "disabled";
  };
}
