{
  inputs,
  pkgs,
  ...
}: {
  users.users.oxce5 = {
    isNormalUser = true; # Regular user account
    initialPassword = "hydenix"; # Default password (CHANGE THIS after first login with passwd)
    extraGroups = [
      "wheel" # For sudo access
      "networkmanager" # For network management
      "video" # For display/graphics access
      "docker"
      "kvm"
      "libvirtd"
      "qemu"
      "scanner"
      "lp"
      "gamemode"
      "adbusers"
      "aria2"
      "docker"
      "wireshark"
      # Add other groups as needed
    ];
    shell = pkgs.zsh; # Change if you prefer a different shell
  };
  security.sudo.extraRules = [
    {
      users = ["oxce5"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];
}
