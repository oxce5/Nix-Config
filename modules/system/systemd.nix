{pkgs, ...}:

{
  systemd.timers."save-uptime" = {
    wantedBy = [ "timers.target" ];
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
    path = with pkgs; [ coreutils gawk bc ];
  };
}
