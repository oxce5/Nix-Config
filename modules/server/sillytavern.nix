{
  unify.modules.sillytavern = {
    home = {
      services.podman = {
        containers.sillytavern = {
          image = "ghcr.io/sillytavern/sillytavern:latest";
          environment = {
            "FORCE_COLOR" = "1";
            "NODE_ENV" = "production";
          };
          network = "host";
          volumes = [
            "/home/sillytavern/SillyTavern/config:/home/node/app/config:rw,Z"
            "/home/sillytavern/SillyTavern/data:/home/node/app/data:rw,Z"
            "/home/sillytavern/SillyTavern/extensions:/home/node/app/public/scripts/extensions/third-party:rw,Z"
            "/home/sillytavern/SillyTavern/plugins:/home/node/app/plugins:rw,Z"
            "/home/sillytavern/SillyTavern/backups:/home/node/app/backups:rw,Z"
          ];
          ports = [
            "8000:8000"
          ];
          extraPodmanArgs = [
            "--hostname=sillytavern"
          ];
          autoStart = true;
        };
      };
    };
  };
}
