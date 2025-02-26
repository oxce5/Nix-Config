{ inputs, pkgs, ...}:

{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    discord
    krita
    betterdiscordctl
    fastfetch
    grimblast
    mpv
    ani-cli
    libreoffice
    blender
    tealdeer
    heroic
    davinci-resolve
    clinfo
    telegram-desktop
    obsidian
    playerctl
    libnotify
    pipes-rs
    cmatrix
    cbonsai
    unzip
    cargo
    arduino-ide

    # Hyprland packages
    waybar
    swww
    rofi
    dunst 
    swaybg
    swaylock
    swayidle
    pamixer
    light
    brillo
  ];
}
