{inputs, ...}: {
  unify.modules.workstation = {
    home = {pkgs, ...}: {
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
        blender_4_1
        pear-desktop
      ];
    };
  };
}
