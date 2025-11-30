{
  unify.modules.hyprland = {
    home = {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            dpi-aware = "no";
            width = 25;
            line-height = 30;
            fields = "name,generic,comment,categories,filename,keywords";
            terminal = "ghostty";
            prompt = "   ";
            layer = "overlay";
          };
          border = {
            radius = 20;
          };

          dmenu = {
            exit-immediately-if-empty = "yes";
          };
        };
      };
    };
  };
}
