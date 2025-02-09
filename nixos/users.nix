{ configs, pkgs, ... }

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


}
