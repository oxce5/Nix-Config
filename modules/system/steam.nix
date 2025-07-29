{
  inputs,
  pkgs,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
  unstable = inputs.nixpkgs.legacyPackages.${pkgs.system};
in {
  programs = {
    steam.enable = true;
    # Fixes using gamescope in steam
    steam.package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };

    gamescope.enable = true;
    gamescope.capSysNice = false; # Breaks gamescope in steam

    adb.enable = true;
    nix-ld = {
      enable = true;
      libraries = pkgs.steam-run.args.multiPkgs pkgs;
    };
    gamemode.enable = true;
  };
}
