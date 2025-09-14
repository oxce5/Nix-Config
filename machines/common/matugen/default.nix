{inputs, ...}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";

    templates = {
      waybar = {
        input_path = "./templates/colors.css";
        output_path = "~/.config/waybar/colors.css";
      };

      zen = {
        input_path = "./templates/zen.css";
        output_path = "~/.zen/sygko1he.Default (release)/chrome/colors.css";
      };

      eww = {
        input_path = "./templates/colors.scss";
        output_path = "~/.config/eww/colors.scss";
      };

      ignis = {
        input_path = "./templates/colors.scss";
        output_path = "~/.config/ignis/colors.scss";
      };

      wofi = {
        input_path = "./templates/colors.css";
        output_path = "~/.config/wofi/colors.css";
      };

      hypr = {
        input_path = "./templates/colors.conf";
        output_path = "~/.config/hypr/colors.conf";
      };

      hyprlock = {
        input_path = "./templates/hyprlock.conf";
        output_path = "~/.config/hypr/hyprlock.conf";
      };

      kitty = {
        input_path = "./templates/kitty.conf";
        output_path = "~/.config/kitty/colors.conf";
        post_hook = "pkill -SIGUSR1 kitty";
      };

      gtk3 = {
        input_path = "./templates/gtk-colors.css";
        output_path = "~/.config/gtk-3.0/colors.css";
        post_hook = "gsettings set org.gnome.desktop.interface gtk-theme \"\"; gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3";
      };

      gtk4 = {
        input_path = "./templates/gtk-colors.css";
        output_path = "~/.config/gtk-4.0/colors.css";
      };

      qt5ct = {
        input_path = "./templates/qt-colors.conf";
        output_path = "~/.config/qt5ct/colors/matugen.conf";
      };

      qt6ct = {
        input_path = "./templates/qt-colors.conf";
        output_path = "~/.config/qt6ct/colors/matugen.conf";
      };

      dunst = {
        input_path = "./templates/dunstrc";
        output_path = "~/.config/dunst/dunstrc";
        post_hook = "pkill dunst";
      };

      pywalfox = {
        input_path = "./templates/pywalfox-colors.json";
        output_path = "~/.cache/wal/colors.json";
        post_hook = "pywalfox update";
      };
    };
  };
}
