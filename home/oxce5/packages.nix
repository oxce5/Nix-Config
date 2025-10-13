{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    kitty
    inputs.winboat.packages.${pkgs.system}.winboat
    freerdp
    inputs.elyprism-launcher.packages.${pkgs.system}.default
    inputs.viu.packages.${pkgs.system}.default
    pavucontrol
    vesktop
    satty
    grim
    slurp
    brave
    networkmanagerapplet
    youtube-music
    trackma-curses
    heroic
    bottles
    lutris
    blender
    obsidian
    # krita
    clang
    mpv
    tealdeer
    motrix
    thunderbird
    libreoffice
  ];
}
