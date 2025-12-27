{inputs, ...}: {
  unify.modules.dms.home = {pkgs, ...}: {
    imports = [
      inputs.dms.homeModules.dankMaterialShell.default
      inputs.dms.homeModules.dankMaterialShell.niri
    ];

    programs.dankMaterialShell = {
      enable = true;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableClipboard = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };
  };

  nixos = {
    systemd.user.services.niri-flake-polkit.enable = false;
  };
}
