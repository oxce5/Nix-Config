{
  pkgs,
  config,
  ...
}: let
  user = "oxce5";
in {
  systemd.timers."save-uptime" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "30m";
      OnUnitActiveSec = "30m";
      Unit = "save-uptime.service";
    };
  };

  systemd.services."save-uptime" = {
    serviceConfig = {
      Type = "oneshot";
      User = "oxce5";
      ExecStart = "${pkgs.bash}/bin/bash ${toString ../../scripts/save_uptime.sh}";
    };
    path = with pkgs; [coreutils gawk bc];
  };

  systemd.user.services.removeXresourcesBackup = {
    description = "Remove .Xresources.backup before Home Manager activation";
    before = ["hm-activate-${user}.service"];
    wants = ["hm-activate-${user}.service"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/rm -f /home/${user}/.Xresources.backup";
    };

    wantedBy = ["default.target"];
  };
}
