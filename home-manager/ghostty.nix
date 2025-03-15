{
  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    enableZshIntegration = true;
    settings = {
      background-opacity = 0.6;  
      font-family = "JetBrainsMono Nerd Font Mono";
      theme = "tokyonight-storm";
      custom-shader = "~/.config/ghostty/bloom.glsl";
    };
  };
}
