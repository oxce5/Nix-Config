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
      custom-shader = "/home/oxce5/hydenix/modules/hm/dots/ghostty/manga_slash.glsl";
      background-opacity = 0.4;
      gtk-titlebar = false;
      keybind = ["ctrl+shift+d=close_surface"];
    };
  };
}
