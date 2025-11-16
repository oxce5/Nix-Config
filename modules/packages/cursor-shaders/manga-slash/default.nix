{
  perSystem = {pkgs, ...}: {
    packages.manga-slash = let
      inherit (pkgs) stdenvNoCC;
    in
      stdenvNoCC.mkDerivation {
        pname = "manga-slash";
        version = "1.0.0";
        src = ./manga-slash.tar.xz;

        unpackPhase = ":";

        buildPhase = ":"; # nothing to build

        installPhase = ''
          mkdir -p $out/share/shaders
          tar --strip-components=0 -xf $src -C $out/share/shaders
        '';
      };
  };
}
