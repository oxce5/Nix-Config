{ config, pkgs, ...}:

{
  networking.networkmanager.enable = true;  
  networking.firewall.allowedTCPPorts = [
    80   # HTTP
    82   # Custom Port (adjust as necessary)
    443  # HTTPS
    3301 # Custom Port (adjust as necessary)
  ];
  networking.firewall.allowedUDPPorts = [
    80
    82
    443
    3301
  ];
  networking.firewall.enable = false;
}

