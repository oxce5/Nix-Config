{ 
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      keybind = [
        "ctrl+shift+d=close_surface"
      ];
      custom-shader = ./manga_slash.glsl;
    };
  };
 }
