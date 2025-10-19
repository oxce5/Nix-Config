{
  unify.modules.workstation = {
    home = 
    {
      stylix = {
        enable = true;
        targets = {
          gtk.enable = true;
          plymouth.enable = false;
        };
        image = ./../../home/oxce5/wallpapers/KASANE_TETO.png;
        polarity = "dark";
      };
    }; 
    
    nixos =
    { lib, ... }:
    {
      stylix = {
        targets = {
          blender.enable = true;
          cava = {
            enable = true;
            rainbow.enable = true;
          };
          gnome.enable = lib.mkForce false;
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
        # image = ./wallpapers/KASANE_TETO.png;
        polarity = "dark";
      };
    };
  };
}
