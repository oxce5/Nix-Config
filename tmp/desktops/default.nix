{
  unify.modules.workstation = {
    nixos =
      { pkgs, ... }:
      {
        programs = {
          dconf.enable = true;
          appimage = {
            enable = true;
            binfmt = true;
          };
        };
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };
        environment = {
          systemPackages = [ pkgs.wl-clipboard ];
          sessionVariables.NIXOS_OZONE_WL = "1";
        };
      };

    home =
      { config, ... }:
      {
        qt.enable = true;
        gtk = {
          enable = true;
          gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
          gtk3 = {
            bookmarks = [
              "file:///home/oxce5/Downloads Downloads"
              "file:///home/oxce5/Documents Documents"
              "file:///home/oxce5/Pictures Pictures"
              "file:///home/oxce5/Videos Videos"
              "file:///home/oxce5/Games Games"
              "file:///home/oxce5/Downloads/tetoes Teto"
            ];
          };
        };
      };
  };
}
