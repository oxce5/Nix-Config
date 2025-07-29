{ lib, config, ... }:

{
  home.file = {
    "${config.xdg.configHome}/mimeapps.list".force = lib.mkForce true;
    ".config/kitty/theme.conf" = lib.mkForce {
      source = ./config/theme.conf;
      force = true;
      mutable = true;
    };
    ".config/hyde/themes/Tokyo Night/wallpapers" = lib.mkForce {
      source = ./assets;
      force = true;
      mutable = true;
      recursive = true;
    };
    ".local/lib/hyde/gamemode.sh" = lib.mkForce {
      source = ./config/gamemode.sh;
      force = true;
      mutable = true;
    };
    ".local/lib/hyde/screenshot.sh" = lib.mkForce {
      source = ./config/screenshot.sh;
      force = true;
      mutable = true;
    };
    ".local/lib/hyde/battery.sh" = lib.mkForce {
      source = ./config/battery.sh;
      force = true;
      mutable = true;
    };
    ".local/share/hyde/config.toml" = lib.mkForce {
      source = ./config/config.toml;
      force = true;
      mutable = true;
    };
  };
}
