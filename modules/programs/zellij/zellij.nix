{inputs, ...}: {
  unify.modules.zellij.home = {
    config,
    pkgs,
    ...
  }: 
    let 
      tokyoNight = {
        base00 = "1a1b26";
        base01 = "16161e";
        base02 = "2f3549";
        base03 = "444b6a";
        base04 = "787c99";
        base05 = "a9b1d6";
        base06 = "cbccd1";
        base07 = "c0caf5";
        base08 = "f7768e";
        base09 = "ff9e64";
        base0A = "e0af68";
        base0B = "9ece6a";
        base0C = "73daca";
        base0D = "7aa2f7";
        base0E = "bb9af7";
        base0F = "db4b4b";
      };
    in {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
        settings = {
        default_shell = "zsh";
        pane_frames = false;
        styled_underlines = true;
        default_layout = "neovim";
        session_serialization = false;
        theme = "tokyo-night-dark";
        copy_clipboard = "primary";
        keybinds = {
          tab = {
            bind = {
              "t" = { action = "ToggleTab"; };
            };
          };

          shared = {
            bind = {
              "Ctrl q" = { action = "Quit"; };
            };
          };
        };

        # Plugins
        plugins = {
          tab-bar.location = "zellij:tab-bar";
          status-bar.location = "zellij:status-bar";
          strider.location = "zellij:strider";
          compact-bar.location = "zellij:compact-bar";
          session-manager.location = "zellij:session-manager";
          zjstatus.location = "file:~/.local/share/zellij/plugins/zjstatus.wasm";

          welcome-screen = {
            location = "zellij:session-manager";
            welcome_screen = true;
          };

          filepicker = {
            location = "zellij:strider";
            cwd = "/";
          };
        };

        # TODO: Convert these kdl files to Nix
        layouts = [
          ./neovim.kdl
          ./terminal.kdl
        ];
      };
    };
  };
};
