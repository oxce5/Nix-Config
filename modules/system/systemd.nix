{
  systemd.timers."save-uptime" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "30m";
        OnUnitActiveSec = "30m";
        Unit = "save-uptime.service";
      };
  };

  systemd.services."save-uptime.service" = {
    script = ../../scripts/save_uptime.sh;
    serviceConfig = {
      Type = "oneshot";
      User = "oxce5";
    };
  };
}
