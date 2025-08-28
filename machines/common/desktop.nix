{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  home-manager.backupFileExtension = "backup";
  environment.systemPackages = with pkgs; [
    unstable.discord

    # Scanning and Printing
    xsane

    # Wine
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg-ntsync

  ];
  programs.zsh.enable = true;
  programs.adb.enable = true;
}
