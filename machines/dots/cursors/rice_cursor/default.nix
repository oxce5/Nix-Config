{stdenv, ...}:
stdenv.mkDerivation {
  pname = "rice-cursor";
  version = "1.0";
  src = ./RiceShower;

  installPhase = ''
    mkdir -p $out/share/icons/Teto_Cursor
    cp -r $src/* $out/share/icons/Teto_Cursor
  '';
}
