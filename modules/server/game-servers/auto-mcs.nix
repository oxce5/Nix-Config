{inputs, ...}: {
  unify.modules.crafty = {
    nixos = {config, ...}: {
      imports = [inputs.playit-nixos-module.nixosModules.default];
      networking.firewall.allowedTCPPorts = [8443 8123];
      networking.firewall.allowedUDPPorts = [19132];
      sops.secrets.playit = {
        owner = "playit";
      };
      sops.templates."playit.toml" = {
        owner = "playit";
        content = ''
          secret_key = "${config.sops.placeholder.playit}"
        '';
      };
      services.playit = {
        enable = true;
        user = "playit";
        group = "playit";
        secretPath = config.sops.templates."playit.toml".path;
      };
    };

    home = {
      services.podman = {
        containers = {
          crafty_container = {
            image = "registry.gitlab.com/crafty-controller/crafty-4:latest";

            environment = {
              TZ = "Etc/UTC";
            };

            ports = [
              "8443:8443/tcp"
              "8123:8123/tcp"
              "19132:19132/udp"
            ];

            volumes = [
              "/home/teto/crafty/backups:/crafty/backups:rw,Z"
              "/home/teto/crafty/logs:/crafty/logs:rw,Z"
              "/home/teto/crafty/servers:/crafty/servers:rw,Z"
              "/home/teto/crafty/config:/crafty/app/config:rw,Z"
              "/home/teto/crafty/import:/crafty/import:rw,Z"
            ];

            extraPodmanArgs = ["--network=host"];

            autoStart = true;
          };
        };
      };
    };
  };
}
