{
  unify.modules.pihole = {
    nixos = {
      pkgs,
      lib,
      hostConfig,
      ...
    }: {
      networking.firewall.allowedTCPPorts = [53 6053 6060 6443 6060];
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
          {
            url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/refs/heads/main/lists/advertising.txt";
            description = "Advertising";
          }
          {
            url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/refs/heads/main/lists/tracking.txt";
            description = "Tracking";
          }
          {
            url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/refs/heads/main/lists/malicious.txt";
            description = "Malicious";
          }
        ];
        settings = {
          dns = {
            dnssec = true;
            domainNeeded = true;
            domain = "tilapia-morpho.ts.net";
            expandHosts = true;
            interface = "";
            listeningMode = "ALL";
            upstreams = [
              "127.0.0.1#5053"
            ];
            hosts = [
              "100.104.244.93 auth.tilapia-morpho.ts.net"
              "100.104.244.93 pihole.tilapia-morpho.ts.net"
              "100.104.244.93 anime.tilapia-morpho.ts.net"
              "100.104.244.93 sillytavern.tilapia-morpho.ts.net"
            ];
            rateLimit = {
              count = 2500;
              interval = 140;
            };
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
