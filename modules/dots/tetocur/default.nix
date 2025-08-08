{pkgs, ...}: let
  teto-cursor = pkgs.stdenv.mkDerivation {
    pname = "teto-cursor";
    version = "1.0";
    src = ./TetoCur;

    installPhase = ''
      mkdir -p $out/share/icons/Teto_Cursor
      cp -r $src/* $out/share/icons/Teto_Cursor
    '';
  };
in {
  home.packages = [
    teto-cursor
  ];

  home.pointerCursor = {
    package = teto-cursor;
    name = "Teto_Cursor";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
