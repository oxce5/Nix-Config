{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  home-manager.backupFileExtension = "backup";
  environment.systemPackages = with pkgs; [

    mate.mate-polkit

    # Scanning and Printing
    xsane

    # Wine
    # inputs.nix-gaming.packages.${pkgs.system}.wine-tkg-ntsync

  ];
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.adb.enable = true;

  services.searx = {
    enable = true;
    settings = {
      server.port = 8080;
      server.bind_address = "0.0.0.0";
      server.secret_key = "lala123!";
    };
  };
}
