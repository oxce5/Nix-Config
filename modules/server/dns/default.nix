{
  unify.modules.pihole = {
    nixos = {
      pkgs,
      lib,
      config,
      hostConfig,
      ...
    }: {
      # networking = {
      #   nameservers = ["127.0.0.1" "::1"];
      #   dhcpcd.extraConfig = "nohook resolv.conf";
      #   networkmanager.dns = "none";
      # };
      sops.secrets.minisign-key = {};

      services = {
        dnscrypt-proxy = {
          enable = true;
          settings = {
            listen_addresses = ["127.0.0.1:5053"];
            ipv6_servers = false;
            require_dnssec = true;
            sources.public-resolvers = {
              urls = [
                "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
                "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
              ];
              cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
              minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            };
          };
        };
      };
      services.resolved.extraConfig = ''
        nameserver 127.0.0.1
        nameserver 1.1.1.1
        DNSStubListener=no
      '';
    };
  };
}
