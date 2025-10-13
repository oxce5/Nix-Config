{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  riceCursor = pkgs.callPackage ./cursors/rice_cursor {};
  tetoCursor = pkgs.callPackage ./cursors/teto_cursor {};

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

  selected = cursorMap.${config.dots.cursor};
in {
  imports = [
    # ./caelestia
    ./noctalia
    ./ghostty
    ./mangohud
    ./nvim
    # ./cursors
    ./yazi
    ./wofi
    ./shell
  ];

  options.dots = {
    bar = mkOption {
      type = lib.types.enum ["caelestia" "noctalia" "exa"];
      default = "noctalia";
    };
    cursor = mkOption {
      type = lib.types.enum ["rice_cursor" "teto_cursor"];
      default = "rice_cursor";
    };
    ghostty = mkOption {
      type = lib.types.bool;
      default = false;
    };
    nvim = mkOption {
      type = lib.types.bool;
      default = false;
    };
    shells = {
      enableZsh = mkOption {
        type = lib.types.bool;
        default = false;
      };
      enableBash = mkOption {
        type = lib.types.bool;
        default = false;
      };
      enableFish = mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
    wofi = mkOption {
      type = lib.types.bool;
      default = false;
    };
    yazi = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    home.packages = [selected.pkg];

    home.sessionVariables = {
      XCURSOR_THEME = selected.name;
      XCURSOR_SIZE = 24;
    };

    home.pointerCursor = {
      package = selected.pkg;
      name = selected.name;
      size = 24;
      gtk.enable = true;
      x11.enable = false; # No .Xresources clobber
    };
  };
}
