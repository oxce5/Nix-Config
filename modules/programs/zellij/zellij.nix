{inputs, ...}: {
  unify.modules.zellij.home = {
    config,
    pkgs,
    lib,
    ...
  }: let
    zjstatus = inputs.zjstatus.packages.${pkgs.system}.default;
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
        default_shell = "fish";
        styled_underlines = true;
        default_layout = "neovim";
        session_serialization = false;
        show_startup_tips = false;
        theme = "tokyo-night-dark";
        keybinds = {
          tab._children = [
            {
              bind = {
                _args = ["t"];
                _children = [
                  {ToggleTab = {};}
                ];
              };
            }
          ];

          shared._children = [
            {
              bind = {
                _args = ["Ctrl q"];
                _children = [
                  {Quit = {};}
                ];
              };
            }
            {
              bind = {
                _args = ["Ctrl ]"];
                _children = [
                  {SwitchToMode._args = ["locked"];}
                ];
              };
            }
          ];
        };

        # Plugins
        plugins = {
          tab-bar.location = "zellij:tab-bar";
          status-bar.location = "zellij:status-bar";
          strider.location = "zellij:strider";
          compact-bar.location = "zellij:compact-bar";
          session-manager.location = "zellij:session-manager";
          zjstatus.location = "file:${zjstatus}/bin/zjstatus.wasm";

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
      };
    };
    xdg.configFile = {
      "zellij/layouts/neovim.kdl".source = ./neovim.kdl;
      "zellij/layouts/terminal.kdl".source = ./terminal.kdl;
    };
  };
}
