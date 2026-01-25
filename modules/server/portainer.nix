{
  unify.modules.portainer = {
    home = {
      services.podman = {
        containers = {
          portainer = {
            image = "portainer/portainer-ce:lts";

            ports = [
              "9443:9443"
              "8888:8000"
            ];
            volumes = [
              "/var/run/docker.sock:/var/run/docker.sock"
              "/home/teto/portainer-data:/data"
            ];
            network = "portainer";
            autoStart = true;
          };
          portainer-agent = {
            image = "portainer/agent:2.33.6";

            volumes = [
              "/run/user/1001/podman/podman.sock:/var/run/docker.sock"

              "/home/teto/portainer-containers/PENTESTING:/data"
              "/:/host"
            ];

            network = "portainer";
            autoStart = true;
          };
        };
        networks.portainer = {
          autoStart = true;
          labels = {
            portainer = "portainer";
          };
          gateway = "192.168.20.1";
          subnet = "192.168.20.0/24";
        };
      };
    };
  };
}
