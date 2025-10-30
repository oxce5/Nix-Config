{
  unify.modules.server = {
    nixos = {
      pkgs,
      hostConfig,
      ...
    }: {
      networking.firewall.allowedTCPPorts = [6060];
      users.users.${hostConfig.primaryUser}.extraGroups = [
        "pihole"
      ];

      services.pihole-ftl = {
        enable = true;
        openFirewallDNS = true;
        openFirewallDHCP = true;
        queryLogDeleter.enable = true;
        lists = [
          {
            url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
            # Alternatively, use the file from nixpkgs. Note its contents won't be
            # automatically updated by Pi-hole, as it would with an online URL.
            # url = "file://${pkgs.stevenblack-blocklist}/hosts";
            description = "Steven Black's unified adlist";
          }
        ];
        settings = {
          dns = {
            domainNeeded = true;
            expandHosts = true;
            interface = "enp0s31f6";
            listeningMode = "BIND";
            upstreams = "8.8.8.8";
          };
          dhcp = {
            active = false;
          };
        };
      };

      # Pi-hole web interface
      services.pihole-web = {
        enable = true;
        ports = [6060];
      };

      # Pi-hole related packages
      environment.systemPackages = with pkgs; [
        pihole-ftl
        pihole-web
        pihole
      ];
    };

    home = {
    };
  };
}
