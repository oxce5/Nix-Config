{
  unify.modules.nextcloud.nixos = {
    config,
    pkgs,
    hostConfig,
    ...
  }: {
    fileSystems."/var/lib/nextcloud/data" = {
      device = "/mnt/ChimeraNAS/Nextcloud/data";
      options = ["bind"];
    };

    networking.firewall.allowedTCPPorts = [12800];
    services.nginx.virtualHosts."localhost".listen = [
      {
        addr = "127.0.0.1";
        port = 12800;
      }
    ];

    users.users.${hostConfig.primaryUser}.extraGroups = ["nextcloud"];
    sops.secrets.nextcloud-pw = {};

    environment.etc."nextcloud-admin-pass".text = config.sops.secrets.nextcloud-pw.path;
    services.nextcloud = {
      autoUpdateApps.enable = true;
      appstoreEnable = true;
      caching.redis = true;
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        adminuser = "teto";
        dbtype = "pgsql";
      };
      settings = {
        trusted_domains = ["localhost" "100.104.244.93" "nextcloud.chimera"];
      };
      database.createLocally = true;
      configureRedis = true;
      enable = true;
      hostName = "localhost";
      https = false;
      package = pkgs.nextcloud31;
    };
  };
}
