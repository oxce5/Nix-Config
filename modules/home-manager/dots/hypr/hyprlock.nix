{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      source = [
        "$HOME/hydenix/modules/hm/dots/hypr/macchiato.conf"
        "$XDG_CONFIG_HOME/hypr/themes/colors.conf"
      ];
      "$BACKGROUND_PATH" = "$XDG_CACHE_HOME/hyde/wall.set.png";
      "$HYPRLOCK_BACKGROUND" = "$XDG_CACHE_HOME/hyde/wallpapers/hyprlock.png";

      accent = "$mauve";
      accentAlpha = "$mauveAlpha";
      font = "CaskaydiaCove Nerd Font";

      general = {
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = false;
      };

      background = {
        monitor = "";
        path = "$BACKGROUND_PATH";
        blur_passes = 3;
        blur_size = 8;
        noise = 0.0117;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.1;
        color = "$base";
      };

      # BORDERS
      label = [
        {
          monitor = "";
          text = "╭─────────────────────────────────────────╮";
          color = "rgba(203, 166, 247, 0.4)";
          font_size = 16;
          font_family = "JetBrains Mono";
          position = "0, 280";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "╰─────────────────────────────────────────╯";
          color = "rgba(203, 166, 247, 0.4)";
          font_size = 16;
          font_family = "JetBrains Mono";
          position = "0, -280";
          halign = "center";
          valign = "center";
        }
        # TIME
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(203, 166, 247, 0.3)";
          font_size = 85;
          font_family = "$font";
          position = "2, 152";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$TIME";
          color = "$text";
          font_size = 80;
          font_family = "$font";
          position = "0, 150";
          halign = "center";
          valign = "center";
          shadow_passes = 3;
          shadow_size = 8;
          shadow_color = "rgba(203, 166, 247, 0.6)";
        }
        # DATE
        {
          monitor = "";
          text = ''cmd[update:3600000] date +"%A, %d %B %Y"'';
          color = "$subtext1";
          font_size = 20;
          font_family = "$font";
          position = "0, 80";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 2;
          shadow_color = "rgba(0, 0, 0, 0.6)";
        }
        # DECORATIVE LABELS (corners etc, add as many as you need...)
        {
          monitor = "";
          text = "╭─";
          color = "rgba(203, 166, 247, 0.6)";
          font_size = 20;
          font_family = "JetBrains Mono";
          position = "15, -15";
          halign = "left";
          valign = "top";
          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgba(203, 166, 247, 0.3)";
        }
        {
          monitor = "";
          text = "─╮";
          color = "rgba(203, 166, 247, 0.6)";
          font_size = 20;
          font_family = "JetBrains Mono";
          position = "-15, -15";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgba(203, 166, 247, 0.3)";
        }
        {
          monitor = "";
          text = "╰─";
          color = "rgba(203, 166, 247, 0.6)";
          font_size = 20;
          font_family = "JetBrains Mono";
          position = "15, 15";
          halign = "left";
          valign = "bottom";
          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgba(203, 166, 247, 0.3)";
        }
        {
          monitor = "";
          text = "─╯";
          color = "rgba(203, 166, 247, 0.6)";
          font_size = 20;
          font_family = "JetBrains Mono";
          position = "-15, 15";
          halign = "right";
          valign = "bottom";
          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgba(203, 166, 247, 0.3)";
        }
        # WELCOME MESSAGE
        {
          monitor = "";
          text = ''Welcome back, $USER'';
          color = "$text";
          font_size = 18;
          font_family = "$font";
          position = "0, -80";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 3;
          shadow_color = "rgba(203, 166, 247, 0.3)";
        }
      ];

      # INPUT FIELD
      input-field = {
        monitor = "";
        size = "280, 45";
        outline_thickness = 2;
        dots_size = 0.25;
        dots_spacing = 0.3;
        dots_center = true;
        dots_rounding = -1;
        outer_color = "$accent";
        inner_color = "$surface0";
        font_color = "$text";
        fade_on_empty = false;
        fade_timeout = 1000;
        placeholder_text = "Password...";
        hide_input = false;
        check_color = "$green";
        fail_color = "$red";
        fail_text = "Authentication Failed! ($ATTEMPTS)";
        capslock_color = "$yellow";
        position = "0, -140";
        halign = "center";
        valign = "center";
        shadow_passes = 4;
        shadow_size = 10;
        shadow_color = "rgba(139, 125, 255, 0.4)";
      };

      # AVATAR IMAGES
      image = [
        {
          monitor = "";
          path = "$HOME/Pictures/profile.jpg";
          size = 95;
          border_size = 1;
          border_color = "rgba(203, 166, 247, 0.2)";
          position = "0, -8";
          halign = "center";
          valign = "center";
          shadow_passes = 4;
          shadow_size = 15;
          shadow_color = "rgba(203, 166, 247, 0.15)";
        }
        {
          monitor = "";
          path = "$HOME/Pictures/profile.jpg";
          size = 80;
          border_size = 3;
          border_color = "$accent";
          position = "0, -10";
          halign = "center";
          valign = "center";
          shadow_passes = 3;
          shadow_size = 8;
          shadow_color = "rgba(139, 125, 255, 0.5)";
        }
      ];
    };

    # For labels with shell commands, weather, system info, particles, and decorative glows,
    # use extraConfig as free-form config.
    extraConfig = ''

      # PARTICLES
      label {
        monitor =
        text = ✦
        color = rgba(203, 166, 247, 0.4)
        font_size = 12
        font_family = $font
        position = -80, 200
        halign = center
        valign = center
      }
      label {
        monitor =
        text = ✧
        color = rgba(245, 194, 231, 0.6)
        font_size = 8
        font_family = $font
        position = 120, -150
        halign = center
        valign = center
      }
      label {
        monitor =
        text = ✨
        color = rgba(139, 213, 202, 0.5)
        font_size = 10
        font_family = $font
        position = -200, -100
        halign = center
        valign = center
      }
      label {
        monitor =
        text = ⭐
        color = rgba(250, 227, 176, 0.4)
        font_size = 6
        font_family = $font
        position = 180, 150
        halign = center
        valign = center
      }
      label {
        monitor =
        text = ◆
        color = rgba(166, 227, 161, 0.3)
        font_size = 14
        font_family = $font
        position = -150, 50
        halign = center
        valign = center
      }

      # WEATHER
      label {
        monitor =
        text = cmd[update:600000] timeout 1s cat /tmp/hyprlock-weather.txt
        color = $sky
        font_size = 14
        font_family = $font
        position = 30, -35
        halign = left
        valign = top
        shadow_passes = 2
        shadow_size = 4
        shadow_color = rgba(137, 220, 235, 0.4)
      }

      # SYSTEM STATUS
      label {
        monitor =
        text = cmd[update:2000] echo "CPU: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' | cut -d. -f1)%"
        color = $peach
        font_size = 12
        font_family = $font
        position = -30, -35
        halign = right
        valign = top
        shadow_passes = 1
        shadow_size = 2
        shadow_color = rgba(250, 179, 135, 0.3)
      }
      label {
        monitor =
        text = cmd[update:3000] free | grep Mem | awk '{printf "RAM: %.0f%%", $3/$2 * 100.0}'
        color = $yellow
        font_size = 12
        font_family = $font
        position = -30, -55
        halign = right
        valign = top
        shadow_passes = 1
        shadow_size = 2
        shadow_color = rgba(250, 227, 176, 0.3)
      }

      # LABEL
      label {
        monitor =
        text = cmd[update:8000] bash $HOME/hydenix/scripts/lines.sh $HOME/hydenix/scripts/shorekeeper.txt
        color = $pink
        font_size = 16
        font_family = $font
        position = 0, -200
        halign = center
        valign = center
        text_align = center
        shadow_passes = 3
        shadow_size = 6
        shadow_color = rgba(245, 194, 231, 0.4)
      }

      # GLOW/DECORATIVE CIRCLES
      label {
        monitor =
        text = ●
        color = rgba(203, 166, 247, 0.05)
        font_size = 400
        font_family = $font
        position = 0, 0
        halign = center
        valign = center
      }
      label {
        monitor =
        text = ●
        color = rgba(245, 194, 231, 0.03)
        font_size = 200
        font_family = $font
        position = -300, 0
        halign = center
        valign = center
      }
      label {
        monitor =
        text = ●
        color = rgba(139, 213, 202, 0.03)
        font_size = 200
        font_family = $font
        position = 300, 0
        halign = center
        valign = center
      }

      # UPTIME
      label {
        monitor =
        text = cmd[update:60000] uptime -p | sed 's/up /⏱️ /'
        color = $green
        font_size = 12
        font_family = $font
        position = 30, 35
        halign = left
        valign = bottom
        shadow_passes = 2
        shadow_size = 3
        shadow_color = rgba(166, 227, 161, 0.4)
      }

      # UPTIME
      label {
        monitor =
        text = cmd[update:60000] bash -c 'BATTERY_ICON=$($HOME/hydenix/modules/hm/config/battery.sh icon); BATTERY_PERCENT=$(/home/oxce5/hydenix/modules/hm/config/battery.sh percentage); echo "$BATTERY_ICON $BATTERY_PERCENT"'
        color = $green
        font_size = 12
        font_family = $font
        position = 30, 45
        halign = left
        valign = bottom
        shadow_passes = 2
        shadow_size = 3
        shadow_color = rgba(166, 227, 161, 0.4)
      }

      # NETWORK STATUS
      label {
        monitor =
        text = cmd[update:5000] timeout 1s bash -c 'if ping -c 1 -W 1 8.8.8.8 &>/dev/null; then echo "● Connected"; else echo "○ Offline"; fi'
        color = $blue
        font_size = 12
        font_family = $font
        position = -30, 35
        halign = right
        valign = bottom
        shadow_passes = 2
        shadow_size = 3
        shadow_color = rgba(137, 220, 235, 0.4)
      }
    '';
  };
}
