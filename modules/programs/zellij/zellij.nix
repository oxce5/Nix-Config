{inputs, ...}: {
  unify.modules.zellij.home = {
    config,
    pkgs,
    lib,
    ...
  }: let
    zjstatus = inputs.zjstatus.packages.${pkgs.system}.default;
  in {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
      attachExistingSession = true;
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
