{
  unify.modules.proxy.nixos = {
    pkgs,
    hostConfig,
    ...
  }: {
    networking.firewall.allowedTCPPorts = [
      81
    ];

    virtualisation.oci-containers.containers.nginx-proxy-manager = {
      image = "jc21/nginx-proxy-manager:latest";
      autoStart = true;
      extraOptions = [
        "--network=host"
      ];
      volumes = [
        "/home/${hostConfig.primaryUser}/Services/nginx-proxy-manager/data:/data"
        "/home/${hostConfig.primaryUser}/Services/nginx-proxy-manager/lets_encrypt:/etc/letsencrypt"
      ];
      ports = [
        "80:80"
        "443:443"
        "81:81"
      ];
    };
  };
}
