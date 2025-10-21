{
  unify = {
    nixos = {pkgs, ...}: {
      services.nextdns = {
        enable = true;
        arguments = [
          "-config"
          "9a438c"
          "-cache-size"
          "10MB"
        ];
      };
      systemd = {
        services.nextdns-activate = {
          script = ''
            ${pkgs.nextdns}/bin/nextdns activate
          '';
          after = ["nextdns.service"];
          wantedBy = ["multi-user.target"];
        };
      };
    };
  };
}
