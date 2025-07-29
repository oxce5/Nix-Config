{ stdenv }:

stdenv.mkDerivation {
  pname = "rice-cursor";
  version = "1.0";
  src = ./config/RiceShower; 

  installPhase = ''
    mkdir -p $out/share/icons/Rice_Cursor
    cp -r $src/* $out/share/icons/Rice_Cursor
  '';
}
