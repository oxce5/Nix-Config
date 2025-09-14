{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Base system tools
    brightnessctl
    ffmpeg
    alejandra
    wl-clipboard
    cliphist
    bibata-cursors
    kitty
    alacritty
    xterm

    # Shell tools
    fzf
    zoxide
    ripgrep
    bat
    bc

    eza
    fd
    curl
    unzip
    wget
    gnumake
    libnotify

    # TUIs
    lazygit
    lazydocker
    btop
    powertop
    fastfetch
    gh

    # Archive and Decompression
    ouch
    p7zip
    nextdns
    lenovo-legion

    python313Packages.aria2p

    # Containers
    docker-compose
  ];
}
