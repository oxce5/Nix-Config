{inputs, ...}: {
  unify.modules.zellij.home = {
    config,
    pkgs,
    ...
  }: {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    xdg.configFile."zellij/layouts/default.kdl".text = let
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

      colors =
        if config.lib ? stylix && config.lib.stylix ? colors
        then config.lib.stylix.colors
        else tokyoNight;

      zjstatus = inputs.zjstatus.packages.${pkgs.system}.default;
    in ''
      layout {
          default_tab_template {
              pane size=2 borderless=true {
                  plugin location="file://${zjstatus}/bin/zjstatus.wasm" {
                      format_left   "{mode}#[bg=#${colors.base00}]"
                      format_center "{tabs}"
                      format_right  "#[fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base01},bold] #[bg=#${colors.base0B},fg=#${colors.base05},bold] {session} #[fg=#${colors.base0B},bold] "
                      format_space  ""
                      format_hide_on_overlength "true"
                      format_precedence "crl"

                      border_enabled  "false"
                      border_char     "─"
                      border_format   "#[fg=#6C7086]{char}"
                      border_position "top"

                      mode_normal        " #[fg=#${colors.base0B}]#[bg=#${colors.base0B},fg=#${colors.base02},bold] NORMAL #[fg=#${colors.base0B}]"
                      mode_locked        " #[fg=#${colors.base04}]#[bg=#${colors.base04},fg=#${colors.base02},bold] LOCKED   #[fg=#${colors.base04}]"
                      mode_resize        " #[fg=#${colors.base08}]#[bg=#${colors.base08},fg=#${colors.base02},bold] RESIZE #[fg=#${colors.base08}]"
                      mode_pane          " #[fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base02},bold] PANE #[fg=#${colors.base0D}]"
                      mode_tab           " #[fg=#${colors.base07}]#[bg=#${colors.base07},fg=#${colors.base02},bold] TAB #[fg=#${colors.base07}]"
                      mode_scroll        " #[fg=#${colors.base0A}]#[bg=#${colors.base0A},fg=#${colors.base02},bold] SCROLL #[fg=#${colors.base0A}]"
                      mode_enter_search  " #[fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base02},bold] ENT-SEARCH #[fg=#${colors.base0D}]"
                      mode_search        " #[fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base02},bold] SEARCHARCH #[fg=#${colors.base0D}]"
                      mode_rename_tab    " #[fg=#${colors.base07}]#[bg=#${colors.base07},fg=#${colors.base02},bold] RENAME-TAB #[fg=#${colors.base07}]"
                      mode_rename_pane   " #[fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base02},bold] RENAME-PANE #[fg=#${colors.base0D}]"
                      mode_session       " #[fg=#${colors.base0E}]#[bg=#${colors.base0E},fg=#${colors.base02},bold] SESSION #[fg=#${colors.base0E}]"
                      mode_move          " #[fg=#${colors.base0F}]#[bg=#${colors.base0F},fg=#${colors.base02},bold] MOVE #[fg=#${colors.base0F}]"
                      mode_prompt        " #[fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base02},bold] PROMPT #[fg=#${colors.base0D}]"
                      mode_tmux          " #[fg=#${colors.base09}]#[bg=#${colors.base09},fg=#${colors.base02},bold] TMUX #[fg=#${colors.base09}]"

                      // formatting for inactive tabs
                      tab_normal              "#[fg=#${colors.base02}]#[bg=#${colors.base02},fg=#${colors.base05},bold]{index}: #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{floating_indicator} #[fg=#${colors.base02},bold]"
                      tab_normal_fullscreen   "#[fg=#${colors.base02}]#[bg=#${colors.base02},fg=#${colors.base05},bold]{index}: #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{fullscreen_indicator} #[fg=#${colors.base02},bold]"
                      tab_normal_sync         "#[fg=#${colors.base02}]#[bg=#${colors.base02},fg=#${colors.base05},bold]{index}: #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{sync_indicator} #[fg=#${colors.base02},bold]"

                      // formatting for the curre
                      tab_active              "#[fg=#${colors.base09}]#[bg=#${colors.base09},fg=#${colors.base05},bold]{index}: #[bg=#${colors.base09},fg=#${colors.base05},bold] {name}{floating_indicator} #[fg=#${colors.base09},bold]"
                      tab_active_fullscreen   "#[fg=#${colors.base09}]#[bg=#${colors.base09},fg=#${colors.base05},bold]{index}: #[bg=#${colors.base09},fg=#${colors.base05},bold] {name}{fullscreen_indicator} #[fg=#${colors.base09},bold]"
                      tab_active_sync         "#[fg=#${colors.base09}]#[bg=#${colors.base09},fg=#${colors.base05},bold]{index}: #[bg=#${colors.base09},fg=#${colors.base05},bold] {name}{sync_indicator} #[fg=#${colors.base09},bold]"

                      // separator between the tabs
                      tab_separator           " "

                      // indicators
                      tab_sync_indicator       " "
                      tab_fullscreen_indicator " 󰊓"
                      tab_floating_indicator   " 󰹙"

                      command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                      command_git_branch_format      "#[fg=blue] {stdout} "
                      command_git_branch_interval    "10"
                      command_git_branch_rendermode  "static"

                      datetime        "#[fg=#6C7086,bold] {format} "
                      datetime_format "%A, %d %b %Y %H:%M"
                      datetime_timezone "Asia/Manila"
                  }
              }
              children
          }
      }
    '';
  };
}
