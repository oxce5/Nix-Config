{
  unify.modules.cachix.nixos = {config, ...}: {
    sops.secrets.cachix_token = {};
    services.cachix-watch-store = {
      enable = false;
      cacheName = "oxce5";
      cachixTokenFile = config.sops.secrets.cachix_token.path;
    };
  };
}
