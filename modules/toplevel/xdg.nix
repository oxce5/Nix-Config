{
  unify = {
    modules.workstation = {
      nixos.xdg = {
        # portal.enable = true;
        terminal-exec.enable = true;
      };
      home.xdg = {
        autostart.enable = true;
        autostart.readOnly = true;
        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = null;
          templates = null;
          music = null;
          publicShare = null;
        };
      };
    };
  };
}
