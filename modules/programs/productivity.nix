{inputs, ...}: {
  unify.modules.workstation = {
    home = {pkgs, ...}:
      with pkgs; let
        patchDesktop = pkg: appName: from: to:
          lib.hiPrio (
            pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
              ${coreutils}/bin/mkdir -p $out/share/applications
              ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
            ''
          );
        GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
      in {
        home.packages = with pkgs; [
          libreoffice
          hunspell
          hunspellDicts.en_US-large
          remmina
          deluge
          proton-pass
          krita
          mpv
          nextcloud-client
          zoom-us
          obsidian
          gearlever
          varia
          vesktop
          (GPUOffloadApp blender_4_1 "blender")
          blender_4_1
          pear-desktop
        ];
      };
  };
}
