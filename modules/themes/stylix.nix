{
  unify.modules.workstation = {
    home = {
      lib,
      hostConfig,
      ...
    }: {
      stylix = {
        targets = {
          blender.enable = true;
          cava = {
            enable = true;
            rainbow.enable = true;
          };
          gnome.enable = lib.mkForce false;
          ghostty.enable = lib.mkForce false;
          vesktop.enable = true;
          fzf.enable = true;
          lazygit.enable = true;
          nvf = {
            enable = true;
            transparentBackground = true;
          };
          qt.enable = true;
          wofi.enable = true;
          yazi.enable = true;
          zellij.enable = true;
        };
        image = hostConfig.primaryWallpaper;
        polarity = "dark";
      };
    };

    nixos = {
      lib,
      hostConfig,
      ...
    }: {
      stylix = {
        enable = true;
        targets = {
          gtk.enable = true;
          plymouth.enable = false;
        };
        image = hostConfig.primaryWallpaper;
        polarity = "dark";
      };
    };
  };
}
