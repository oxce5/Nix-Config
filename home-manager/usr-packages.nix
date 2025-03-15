{ inputs, pkgs, ...}:

{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    discord
    blender
    krita
    betterdiscordctl
    fastfetch
    grimblast
    mpv
    ani-cli
    libreoffice
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
    udiskie
    fritzing
    thunderbird
    yt-dlp
    tmux
    tmuxinator
    lazygit


    # Hyprland packages
    rofi
    swaybg
    swaylock
    swayidle
    pamixer
    light
    brillo
  ];
}
