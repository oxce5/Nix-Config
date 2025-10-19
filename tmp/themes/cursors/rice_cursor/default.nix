{stdenv, ...}:
stdenv.mkDerivation {
  pname = "rice-cursor";
  version = "1.0";
  src = ./RiceShower.tar.xz;

  installPhase = ''
    mkdir -p $out/share/icons/RiceCursor
    tar --strip-components=1 -xf $src -C $out/share/icons/RiceCursor
  '';
}
