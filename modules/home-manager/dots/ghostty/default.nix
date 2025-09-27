{
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.system}.default;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    settings = {
      theme = "Tomorrow Night Burns"; 
      custom-shader = builtins.toString ./manga_slash.glsl;
      custom-shader-animation = true;

      font-family = "JetBrainsMono Nerd Font";
      font-size = 10;

      adjust-underline-position = 3;

      gtk-titlebar = false;

      background = "#111111";
      background-opacity = 0.8;

      unfocused-split-opacity = 1;
      focus-follows-mouse = true;

      
      window-padding-x = 10;
      window-padding-y = 10;

      keybind = ["ctrl+shift+d=close_surface"];
    };
  };
}
