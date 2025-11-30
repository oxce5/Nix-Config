{
  unify.modules.sillytavern.home = {
    pkgs,
    lib,
    ...
  }: {
    services.podman.containers.sillytavern = {
      image = "ghcr.io/sillytavern/sillytavern:latest";
      user = "sillytavern";
      environment = {
        "FORCE_COLOR" = "1";
        "NODE_ENV" = "production";
      };
      volumes = [
        "/home/sillytavern/SillyTavern/config:/home/node/app/config:rw,Z"
        "/home/sillytavern/SillyTavern/data:/home/node/app/data:rw,Z"
        "/home/sillytavern/SillyTavern/extensions:/home/node/app/public/scripts/extensions/third-party:rw,Z"
        "/home/sillytavern/SillyTavern/plugins:/home/node/app/plugins:rw,Z"
      ];
      ports = [
        "8000:8000/tcp"
      ];
      extraOptions = [
        "--hostname=sillytavern"
      ];
      autoStart = true;
      restartPolicy = "always";
    };
  };
}
