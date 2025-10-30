{
  unify.modules.server = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        cockpit
      ];

      services.cockpit = {
        enable = true;
        port = 9090;
        openFirewall = true; # Please see the comments section
        settings = {
          # WebService = {
          #   AllowUnencrypted = true;
          # };
        };
        allowed-origins = [
          "https://192.168.1.26:9090"
          "ws://192.168.1.26:9090"
          "https://chimera:9090"
          "ws://chimera:9090"
        ];
      };
    };
    home = {
    };
  };
}
