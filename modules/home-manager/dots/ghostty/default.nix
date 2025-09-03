{
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      custom-shader = builtins.toString ./manga_slash.glsl;
      custom-shader-animation = true;

      font-family = "JetBrainsMono Nerd Font";
      font-size = 10;

      gtk-titlebar = false;

      background = "#111111";
      background-opacity = 0.8;

      unfocused-split-opacity = 1;
      focus-follows-mouse = true;

      keybind = ["ctrl+shift+d=close_surface"];
    };
  };
}
