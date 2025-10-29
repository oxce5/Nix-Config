{
  unify.modules.server = {
    nixos = {
      services = {
        searx = {
          enable = true;
          configureNginx = true;
          domain = "searxng.nix";
        };
      };
    };

    home = {
    };
  };
}
