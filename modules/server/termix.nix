{
  unify.modules.termix = {
     home = {
      services.podman = {
        containers = {
          crafty_container = {
            image = "ghcr.io/lukegus/termix:latest";
            environment = {
              PORT = 8000;
            };
            ports = [
              "8000:8000"
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
