{stdenv, ...}:
stdenv.mkDerivation {
  pname = "teto-cursor";
  version = "1.0";
  src = ./TetoCur.tar.xz;

  installPhase = ''
    mkdir -p $out/share/icons/Teto_Cursor
    tar -xf $src -C $out/share/icons/Teto_Cursor
  '';
}
