{
  unify.modules.workstation = {
    nixos =
      { pkgs, ... }:
      {
        fonts = {
          packages = with pkgs; [
            jetbrains-mono
            montserrat
            libertine
            inter
            openmoji-color
            nerd-fonts.symbols-only
            atkinson-hyperlegible-next
          ];
          enableDefaultPackages = true;
          fontDir.enable = true;
          fontconfig.defaultFonts = {
            sansSerif = [ "Atkinson Hyperlegible Next" ];
            serif = [ "Liberation Serif" ];
            monospace = [ "JetBrains Mono" ];
            emoji = [ "OpenMoji Color" ];
          };
        };
      };

    home =
      { lib, pkgs, ... }:
      {
        home = 
        let 
          rice_cursor = pkgs.callPackage ./cursors/rice_cursor {};
          teto_cursor = pkgs.callPackage ./cursors/teto_cursor {};
        in {
          pointerCursor = {
              package = teto_cursor;
              name = "Teto_Cursor";
              size = 24;
              gtk.enable = true;
              x11.enable = false;
          };
          packages = [ teto_cursor ];

          sessionVariables = {
            XCURSOR_THEME = "Teto_Cursor";
            XCURSOR_SIZE = 24;
          };
        };
      };
  };
}
