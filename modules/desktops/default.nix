{
  unify.modules.workstation = {
    nixos = {pkgs, ...}: {
      programs = {
        dconf.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
        };
        nix-ld.enable = true;
      };
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [xdg-desktop-portal-gtk];
      };
      environment = {
        systemPackages = [pkgs.wl-clipboard];
        sessionVariables.NIXOS_OZONE_WL = "1";
      };
    };

    home = {config, ...}: {
      qt.enable = true;
      gtk = {
        enable = true;
        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        gtk3 = {
          bookmarks = [
            "file://${config.home.homeDirectory}/Downloads Downloads"
            "file://${config.home.homeDirectory}/Documents Documents"
            "file://${config.home.homeDirectory}/Pictures Pictures"
            "file://${config.home.homeDirectory}/Videos Videos"
            "file://${config.home.homeDirectory}/Games Games"
            "file://${config.home.homeDirectory}/Downloads/tetoes Teto"
          ];
        };
      };
    };
  };
}
