{
  unify.modules.termix = {
    home = {
      services.podman = {
        containers = {
          termix = {
            image = "ghcr.io/lukegus/termix:latest";
            environment = {
              PORT = 9000;
            };
            ports = [
              "9000:9000"
            ];
            volumes = [
              "/home/teto/termix-data:/app/data"
            ];
            extraPodmanArgs = ["--network=host"];
            autoStart = true;
          };
        };
      };
    };
  };
}
