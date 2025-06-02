{ lib, config, ... }:

{
  home.file = {
    ".config/hypr/userprefs.conf" = lib.mkForce {
      source = ./config/userprefs.conf;
      force = true;
      mutable = true;
    };
    ".config/hypr/keybindings.conf" = lib.mkForce {
      source = ./config/keybindings.conf;
      force = true;
      mutable = true;
    };
    "${config.xdg.configHome}/mimeapps.list".force = lib.mkForce true;
    ".config/kitty/theme.conf" = lib.mkForce {
      source = ./config/theme.conf;
      force = true;
      mutable = true;
    };
    ".config/kitty/kitty.conf" = lib.mkForce {
      source = ./config/kitty.conf;
      force = true;
      mutable = true;
    };
    ".config/hyde/themes/Tokyo Night/wallpapers" = lib.mkForce {
      source = ./assets;
      force = true;
      mutable = true;
      recursive = true;
    };
    ".local/share/hyde/hyprland.conf" = lib.mkForce {
      source = ./config/hyprland_hyde.conf;
      force = true;
      mutable = true;
    };
  };
}
