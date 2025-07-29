{pkgs, ...}: let
  rice-cursor = pkgs.stdenv.mkDerivation {
    pname = "rice-cursor";
    version = "1.0";
    src = ./RiceShower;

    installPhase = ''
      mkdir -p $out/share/icons/Rice_Cursor
      cp -r $src/* $out/share/icons/Rice_Cursor
    '';
  };
in {
  home.packages = [
    rice-cursor
  ];

  home.pointerCursor = {
    package = rice-cursor;
    name = "Rice_Cursor";
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };
}
