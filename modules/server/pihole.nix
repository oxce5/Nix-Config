{
  unify.modules.server = {
    nixos = {
      services = {
        pihole-ftl = {
          enable = true;
        };

        pihole-web = {
          enable = true;
          ports =[ "80r" "443s" ];
        };
      };
    };

    home = {
    };
  };
}
