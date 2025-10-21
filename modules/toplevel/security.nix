{lib, ...}: {
  unify.nixos.security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
    sudo-rs.extraRules = [
      {
        users = ["oxce5"];
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
    polkit.enable = true;
    pam = {
      services.systemd-run0 = {};
      loginLimits = lib.singleton {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "unlimited";
      };
    };
  };
}
