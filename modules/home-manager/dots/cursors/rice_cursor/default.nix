{stdenv, ...}:
stdenv.mkDerivation {
  pname = "rice-cursor";
  version = "1.0";
  src = ./RiceShower.tar.xz;

  installPhase = ''
    mkdir -p $out/share/icons/Rice_Cursor
    tar -xf $src -C $out/share/icons/Rice_Cursor
  '';
}
