{
  perSystem = {pkgs, ...}: {
    packages.teto-cursor = let
      inherit (pkgs) stdenvNoCC;
    in
      stdenvNoCC.mkDerivation {
        pname = "teto-cursor";
        version = "1.0";
        src = ./TetoCursor.tar.xz;

        installPhase = ''
          mkdir -p $out/share/icons/TetoCursor
          tar --strip-components=1 -xf $src -C $out/share/icons/TetoCursor
        '';
      };
  };
}
