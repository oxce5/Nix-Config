{self, ...}: {
  unify.modules.ghostty = {
    nixos.xdg.terminal-exec.settings.default = ["com.mitchellh.ghostty.desktop"];
    home = {
      programs.ghostty = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = {
          shell-integration = "detect";
          background-opacity = 0.8;
          shell-integration-features = "ssh-env,ssh-terminfo";
          custom-shader = "${self.packages.x86_64-linux.manga-slash}/share/shaders/manga-slash.glsl";
          custom-shader-animation = "always";
          window-decoration = "server";
          window-padding-x = 4;
          window-padding-color = "extend";
          window-padding-balance = true;
          keybind = [
            "ctrl+alt+v=new_split:right"
            "ctrl+alt+s=new_split:down"
            "ctrl+alt+n=new_split:auto"
            "ctrl+shift+h=goto_split:left"
            "ctrl+shift+j=goto_split:bottom"
            "ctrl+shift+k=goto_split:top"
            "ctrl+shift+l=goto_split:right"
            "ctrl+shift+w=close_surface"
            "page_up=scroll_page_fractional:-0.5"
            "page_down=scroll_page_fractional:+0.5"
            "ctrl+shift+r=reload_config"
          ];
        };
      };
    };
  };
}
