{
  unify.modules.workstation = {
    home = {
      lib,
      pkgs,
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
        image = pkgs.fetchurl {
          url = "https://static.wikia.nocookie.net/synthv/images/9/9b/Synthesizer_V_AI_KASANE_TETO_Illust.png/revision/latest?cb=20240831225511";
          hash = "sha256-JFJJGc+84RCAes06wm8tpARaAfPwpWHDLtgSuqjn9DM=";
        };
        polarity = "dark";
      };
    };

    nixos = {
      lib,
      pkgs,
      ...
    }: {
      stylix = {
        enable = true;
        targets = {
          gtk.enable = true;
          plymouth.enable = false;
        };
        image = pkgs.fetchurl {
          url = "https://static.wikia.nocookie.net/synthv/images/9/9b/Synthesizer_V_AI_KASANE_TETO_Illust.png/revision/latest?cb=20240831225511";
          hash = "sha256-JFJJGc+84RCAes06wm8tpARaAfPwpWHDLtgSuqjn9DM=";
        };
        polarity = "dark";
      };
    };
  };
}
