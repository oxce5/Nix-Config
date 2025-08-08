{ pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # kitty
    inputs.elyprism-launcher.packages.${pkgs.system}.default
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    youtube-music
    trackma-curses
    heroic
    bottles
    lutris
    blender
    obsidian
    blender
    zoxide
    krita
    clang
    mpv
    tealdeer
    motrix
    thunderbird
    proton-caller
  ];
}
