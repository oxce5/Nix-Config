{pkgs, inputs, ...}:

{
  imports = [ inputs.caelestia-shell.homeManagerModules.default ];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [];
    };
    settings = {
      bar = {
        workspaces = {
          windowIconSize = 28;
        };
        status = {
          showBattery =  true;
        };
        persistent = true;
        showOnHover = true;
      };
      paths.wallpaperDir = "~/Images";
      services = {
        useFahrenheit = false;
      };
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = true;
      };
    };
  };
}
