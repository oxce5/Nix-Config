{
  unify.modules.hyprland.home = {
    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";

          modules-left = ["clock"];
          modules-center = ["custom/state"];
          modules-right = ["custom/vpn" "hostname"];

          # --- CLOCK (24h, required format) -----------------------------------
          clock = {
            # Result example: SYSTIME 03.05.2025-17.43.12
            format = "SYSTIME {:%m.%d.%Y-%H.%M.%S}";
            interval = 1;
          };

          # --- REVERSE SHELL STATE -------------------------------------------
          "custom/state" = {
            exec = "~/.local/bin/detect-revshell.sh";
            interval = 1;
            format = "STATE: {}";
            return-type = "string";
          };

          # --- VPN STATUS -----------------------------------------------------
          "custom/vpn" = {
            exec = ''
              if ip link show tun0 >/dev/null 2>&1; then
                echo "VPN: UP"
              else
                echo "VPN: DOWN"
              fi
            '';
            interval = 3;
            format = "{}";
          };

          # --- HOSTNAME -------------------------------------------------------
          hostname = {
            format = "{}";
          };
        };
      };

      style = ''
        * {
          font-size: 12pt;
          font-family: JetBrainsMono, monospace;
        }

        #custom-state {
          font-weight: bold;
        }
        #custom-state.local {
          color: #42ff42;
        }
        #custom-state.target {
          color: #ffea42;
        }

        #custom-vpn {
          font-weight: bold;
        }
      '';
    };
  };
}
