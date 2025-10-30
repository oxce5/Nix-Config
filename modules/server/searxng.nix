{
  unify.modules.server = {
    nixos = {
      networking.firewall.allowedTCPPorts = [8080];

      services = {
        searx = {
          enable = true;
          configureNginx = true;
          domain = "searxng.nix";
          settings = {
            server.port = 8080;
            server.bind_address = "0.0.0.0";
            server.secret_key = "lalalala";
          };
        };
      };
    };

    home = {
    };
  };
}
