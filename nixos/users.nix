{ configs, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.oxce5 = {
    isNormalUser = true;
    description = "oxce5_root";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
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

}
