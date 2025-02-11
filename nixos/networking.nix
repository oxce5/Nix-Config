{ config, pkgs, ...}:

{
  networking.networkmanager.enable = true;  
  networking.firewall.allowedTCPPorts = [
    80   # HTTP
    82   # Custom Port (adjust as necessary)
    443  # HTTPS
    3301 # Custom Port (adjust as necessary)
    25565
    19132
    13350
    61585 
  ];
  networking.firewall.allowedUDPPorts = [
    80
    82
    443
    3301
    25565
    19132
    3191
  ];
  networking.firewall.enable = false;
}

