{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  pname = "PRTS";
  version = "1.0.0";
  src = ./prts-plymouth.tar.xz;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/prts-plymouth
    tar -xf $src -C $out/share/plymouth/themes/prts-plymouth
    chmod +x $out/share/plymouth/themes/prts-plymouth/prts-plymouth.plymouth
    substituteInPlace $out/share/plymouth/themes/prts-plymouth/prts-plymouth.plymouth --replace '@IMAGES@' "$out/share/plymouth/themes/prts-plymouth/img/"
    substituteInPlace $out/share/plymouth/themes/prts-plymouth/prts-plymouth.plymouth --replace '@SCRIPT@' "$out/share/plymouth/themes/prts-plymouth/animated-boot.script"
  '';
}
