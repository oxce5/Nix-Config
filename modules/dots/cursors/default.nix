{ lib, config, pkgs, ... }:

with lib;

let
  riceCursor = pkgs.callPackage ./rice_cursor { };
  tetoCursor = pkgs.callPackage ./teto_cursor { };

  cursorMap = {
    rice_cursor = {
      pkg = riceCursor;
      name = "Rice_Cursor";
    };
    teto_cursor = {
      pkg = tetoCursor;
      name = "Teto_Cursor";
    };
  };

  selected = cursorMap.${config.cursor};
in
{
  options.cursor = mkOption {
    type = types.enum [ "rice_cursor" "teto_cursor" ];
    default = "rice_cursor";
    description = "Choose which cursor theme to use.";
  };

  config = {
    home.packages = [ selected.pkg ];

    home.sessionVariables = {
      XCURSOR_THEME = selected.name;
      XCURSOR_SIZE  = "24";
    };

    home.pointerCursor = {
      package = selected.pkg;
      name = selected.name;
      size = 24;
      gtk.enable = true;
    };
  };
}
