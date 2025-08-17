{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (obs-studio.override {
      cudaSupport = true;
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
    uv
    python314Full
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg-ntsync
    winetricks
    protontricks
    ripgrep
    bc
    alejandra
    timeshift
    bat
    nix-ld
    nextdns
    lenovo-legion

    python313Packages.aria2p
  ];

  programs.gpu-screen-recorder.enable = true;
}
