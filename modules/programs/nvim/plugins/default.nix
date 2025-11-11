{
  unify.modules.neovim = {
    home = {pkgs, ...}: let
      vimPlug = pkgs.vimPlugins;
    in {
      programs.nvf.settings.vim = {
        extraPlugins = {
          no-neck-pain.package = vimPlug.no-neck-pain-nvim;
          firenvim.package = vimPlug.firenvim;
          tiny-glimmer = {
            package = vimPlug.tiny-glimmer-nvim;
            setup = ''
              require("tiny-glimmer").setup({
                  enabled = true,
                  disable_warnings = true,
                  refresh_interval_ms = 8,
                  overwrite = {
                      auto_map = true,
                      yank = {
                          enabled = true,
                          default_animation = "fade",
                      },
                      search = {
                          enabled = true,
                          default_animation = "pulse",
                          next_mapping = "n",      -- Key for next match
                          prev_mapping = "N",      -- Key for previous match
                      },
                      paste = {
                          enabled = true,
                          default_animation = "reverse_fade",
                          paste_mapping = "p",     -- Paste after cursor
                          Paste_mapping = "P",     -- Paste before cursor
                      },
                      undo = {
                          enabled = true,
                          default_animation = {
                              name = "fade",
                              settings = {
                                  from_color = "DiffDelete",
                                  max_duration = 500,
                                  min_duration = 500,
                              },
                          },
                          undo_mapping = "u",
                      },
                      redo = {
                          enabled = true,
                          default_animation = {
                              name = "fade",
                              settings = {
                                  from_color = "DiffAdd",
                                  max_duration = 500,
                              },
                          },
                          redo_mapping = "<c-r>",
                      },
                  },
                  support = {
                      -- Support for gbprod/substitute.nvim
                      -- Usage: require("substitute").setup({
                      --     on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
                      --     highlight_substituted_text = { enabled = false },
                      -- })
                      substitute = {
                          enabled = false,
                          default_animation = "fade",
                      },
                  },
                  transparency_color = nil,

                  animations = {
                      fade = {
                          max_duration = 400,              -- Maximum animation duration in ms
                          min_duration = 300,              -- Minimum animation duration in ms
                          easing = "outQuad",              -- Easing function
                          chars_for_max_duration = 10,    -- Character count for max duration
                          from_color = "Visual",           -- Start color (highlight group or hex)
                          to_color = "Normal",             -- End color (highlight group or hex)
                      },
                      reverse_fade = {
                          max_duration = 380,
                          min_duration = 300,
                          easing = "outBack",
                          chars_for_max_duration = 10,
                          from_color = "Visual",
                          to_color = "Normal",
                      },
                      bounce = {
                          max_duration = 500,
                          min_duration = 400,
                          chars_for_max_duration = 20,
                          oscillation_count = 1,          -- Number of bounces
                          from_color = "Visual",
                          to_color = "Normal",
                      },
                      left_to_right = {
                          max_duration = 350,
                          min_duration = 350,
                          min_progress = 0.85,
                          chars_for_max_duration = 25,
                          lingering_time = 50,            -- Time to linger after completion
                          from_color = "Visual",
                          to_color = "Normal",
                      },
                      pulse = {
                          max_duration = 600,
                          min_duration = 400,
                          chars_for_max_duration = 15,
                          pulse_count = 2,                -- Number of pulses
                          intensity = 1.2,                -- Pulse intensity
                          from_color = "Visual",
                          to_color = "Normal",
                      },
                      rainbow = {
                          max_duration = 600,
                          min_duration = 350,
                          chars_for_max_duration = 20,
                          -- Note: Rainbow animation does not use from_color/to_color
                      },
                  },

                  hijack_ft_disabled = {
                      "alpha",
                      "dashboard",
                      "snacks_dashboard",
                  },

                  virt_text = {
                      priority = 2048,  -- Higher values appear above other plugins
                  },
              })
            '';
          };
        };
      };
    };
  };
}
