{
  unify = {
    modules.server = {
      nixos = {
        config,
        hostConfig,
        ...
      }: {
        virtualisation = {
          podman = {
            enable = true;
            dockerCompat = true;
            dockerSocket.enable = true;
            defaultNetwork.settings.dns_enabled = true;
          };
          oci-containers = {
            backend = "podman";
          };
          containers = {
            enable = true;
            containersConf.settings = {
              containers = {
                dns_servers = ["100.104.244.93"];
              };
              network = {
                dns_bind_port = 54;
              };
            };
          };
        };
        networking = {
          firewall.allowedTCPPorts = [9117 8989 7878];
          firewall.allowedUDPPorts = [53 54 5053 5353];
          nat.enable = true;
        };
        users.users.${hostConfig.primaryUser}.extraGroups = ["podman"];
      };
      home = {
        services.podman = {
          enable = true;
        };
      };
    };
  };
}
