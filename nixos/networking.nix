{ config, pkgs, ...}:

{
  networking.networkmanager.enable = true;  
  networking.firewall.allowedTCPPorts = [
    67
    53
    68
    80   # HTTP
    82   # Custom Port (adjust as necessary)
    443  # HTTPS
    3301 # Custom Port (adjust as necessary)
    8080
  ];
  networking.firewall.allowedUDPPorts = [
    67
    53
    68
    80
    82
    443
    3301
  ];
  networking.firewall.enable = true;
  networking.firewall.extraForwardRules = [
    "-j ACCEPT"
  ];

  }

