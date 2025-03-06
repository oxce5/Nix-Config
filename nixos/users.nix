{ configs, pkgs, ... }:

{
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.oxce5 = {
    isNormalUser = true;
    description = "oxce5_root";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "oxce5";
  
  security.sudo.extraRules= [
  {  users = [ "oxce5" ];
    commands = [
       { command = "ALL" ;
         options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];
  users.users.http = {
     isNormalUser = true;
  };

  
  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
    home = "/var/lib/cloudflared";
    createHome = true;
    shell = "/run/current-system/sw/bin/nologin"; # Prevents login access
  };

  users.groups.cloudflared = {};
}
