{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.jerry.packages.${pkgs.system}.default
    (obs-studio.override {
      cudaSupport = true;
    })
    (import ./kurukurubar.nix {
      inherit symlinkJoin makeWrapper quickshell kdePackages lib;
      makeFontsConf = pkgs.makeFontsConf;
      nerd-fonts = pkgs.nerd-fonts.caskaydia-mono;
      material-symbols = pkgs.material-symbols;
    })
    atuin
    nvidia-vaapi-driver
    sbctl
    xsane
    waydroid-helper
    cloudflare-warp
    ouch
    p7zip
    ffmpeg-full
    python314Full
    uv
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg-ntsync
    unstable.winetricks
    unstable.protontricks
    ripgrep
    alejandra
    timeshift
    bat
    nix-ld
    nextdns
    lenovo-legion

    unstable.python313Packages.aria2p
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];
}
