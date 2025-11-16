{inputs, ...}: {
  unify.modules.workstation = {
    home = {pkgs, ...}: {
      home.packages = with pkgs; [
        libreoffice
        hunspell
        hunspellDicts.en_US-large
        remmina
        varia
        proton-pass
        krita
        mpv
        nextcloud-client
        obsidian
        gearlever
        vesktop
        blender
        youtube-music
      ];
    };
  };
}
