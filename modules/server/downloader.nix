{
  unify.modules.downloader.nixos = {
    pkgs,
    hostConfig,
    ...
  }: {
    users.users.${hostConfig.primaryUser}.extraGroups = [
      "deluge"
    ];

    networking.firewall.allowedTCPPorts = [9091];

    services.deluge = {
      enable = true;
      openFirewall = true;
      web = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
