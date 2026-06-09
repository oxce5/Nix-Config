{
  den.default.nixos.security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
    polkit.enable = true;
    # pam = {
    #   services.systemd-run0 = { };
    #   loginLimits = [
    #     {
    #       domain = "*";
    #       item = "nofile";
    #       type = "hard";
    #       value = 128000;
    #     }
    #     {
    #       domain = "*";
    #       item = "nofile";
    #       type = "soft";
    #       value = 20480;
    #     }
    #     {
    #       domain = "oxce5";
    #       item = "rtprio";
    #       type = "-";
    #       value = "98";
    #     }
    #     {
    #       domain = "oxce5";
    #       item = "nice";
    #       type = "-";
    #       value = -20;
    #     }
    #   ];
    # };
  };
}
