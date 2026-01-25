{
  unify.modules.neovim = {
    home = {
      programs.nvf.settings.vim = {
        statusline.lualine = {
          enable = true;
          activeSection.c = [
            ''
              {
                "diagnostics",
                sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc' },
                symbols = { error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 ' },
                colored = true,
                update_in_insert = false,
                always_visible = false,
                diagnostics_color = {
                  color_error = { fg = 'red' },
                  color_warn = { fg = 'yellow' },
                  color_info = { fg = 'cyan' },
                },
              }
            ''
          ];
          activeSection.x = [
            ''
              {
                -- Lsp server name
                function()
                  local buf_ft = vim.bo.filetype
                  local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

                  if excluded_buf_ft[buf_ft] then
                    return ""
                  end

                  local bufnr = vim.api.nvim_get_current_buf()
                  local clients = vim.lsp.get_clients({ bufnr = bufnr })

                  if vim.tbl_isempty(clients) then
                    return "No Active LSP"
                  end

                  local active_clients = {}
                  for _, client in ipairs(clients) do
                    table.insert(active_clients, client.name)
                  end

                  return table.concat(active_clients, ", ")
                end,
                icon = ' ',
                separator = { left = '' },
              }
            ''
            ''
              {
                function() return require("noice").api.status.command.get() end,
                cond = function() return require("noice").api.status.command.has() end,
              }
            ''
          ];
        };
        telescope.enable = true;
        notify.nvim-notify.enable = true;
        ui = {
          noice = {
            enable = true;
          };
          nvim-ufo = {
            enable = true;
            setupOpts = {};
          };
        };
        terminal.toggleterm = {
          lazygit.enable = true;
        };

        utility.oil-nvim = {
          enable = true;
          gitStatus.enable = true;
        };

        visuals = {
          indent-blankline = {
            enable = true;
            setupOpts = {
              indent = {
                char = "";
                priority = 36;
              };
              exclude = {
                buftypes = [
                  "terminal"
                  "nofile"
                  "quickfix"
                  "prompt"
                  "dashboard"
                ];
                filetypes = [
                  "dashboard"
                ];
              };
              scope = {
                char = "▏";
                show_exact_scope = true;
                show_start = true;
                show_end = true;
                highlight = [
                  "RainbowRed"
                  "RainbowYellow"
                  "RainbowBlue"
                  "RainbowOrange"
                  "RainbowGreen"
                  "RainbowViolet"
                  "RainbowCyan"
                ];
              };
            };
          };
          rainbow-delimiters.enable = true;
        };

        notes = {
          todo-comments.enable = true;
        };

        dashboard.dashboard-nvim = {
          enable = true;
          setupOpts = {
            theme = "doom";
            config = {
              header = [
                "                          ⢀⣀⣀⠸⠿⠿⢿⣿                     "
                "                          ⢸⡟⠛   ⢸⣿                     "
                "                          ⣸⡇   ⣶⣾⣿                     "
                "                        ⢸⣿⣿⡇   ⠿⠿⠿   ⣀⣸⡿⣃⡀   ⣀⡀        "
                "                     ⣠⣤ ⠘⠛⠛⠃         ⣿⡇ ⢹⡇ ⢠⣤⠻⢣⣤       "
                "                    ⣶⡛⠛            ⢰⣶⠛⠃ ⠙⢳⣶⡞⠛ ⢸⣿       "
                "                  ⢰⣿⣿⠁             ⢸⣿         ⢸⣿       "
                "       ⢀⣀⣀⣀⣀⣀⣀⣀   ⢸⣿⣿⠁ ⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀ ⣿⡇          ⢸⣿       "
                "      ⣤⣼⣿⣿⣿⣿⣿⣿⣿⣤⡄ ⠘⠛⣿⣧⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣿⡇  ⢠⣤     ⣤⣼⣿⣤⡄     "
                "      ⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇ ⣶⡎⠉   ⢰⣶⣿⣿⣿⠉⠁     "
                "    ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣀⣀⣀⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿    "
                "    ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    "
                "    ⠈⠉⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠉⠉⠉    "
                "    ⢰⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶    "
                "    ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠃ ⠛⢻⣿⣿⣿⣿⣿⡿⠛⠃ ⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    "
                "    ⠘⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠉     ⠉⢻⣿⣿⠋⠁    ⠈⠉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛    "
                "      ⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿   ⢰⣶   ⠈⠉⠉   ⢰⣶   ⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡆     "
                "      ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇   ⣿⡇ ⣿⡇      ⣿⡏⠉⣿⡆   ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇     "
                "      ⠛⠛⠛⣿⣿⣿⣿⣿⣿⣿⣇⣀  ⠛⠃ ⠛⠃      ⠛⠃ ⠛⠃ ⢀⣠⣿⣿⣿⣿⣿⣿⣿⡟⠛⠛⠃     "
                "       ⢠⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⡄ ⢠⣤         ⢠⣤   ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤       "
                "         ⣿⣿⣿⣿⡏ ⢻⣿⣿     ⣶⣶⣶⣶⣶⣶⣶⣶⣶⡆  ⠠⠶⣿⣿⣿⠁⠈⣿⣿⣿⣿⡏        "
                "         ⠿⢿⣿⣿⡇   ⠿⣀⣀   ⠿⢇⣀   ⣀⣀⠿⠇  ⢀⣀⠿⠇   ⣿⣿⣿⠿⠇        "
                "          ⠘⠛⣿⡇    ⠛⠛⣤⣤⣤ ⠘⠛⣤⣤⣤⡟⠛ ⢠⣤⣤⡜⠛     ⣿⡟⠛          "
                "            ⠉⠁      ⠛⠛⠛⣤⣤⣤⣿⣿⣿⣧⣤⣤⡜⠛⠛⠃      ⠉⠁           "
                "                                                       "
              ];
              center = [
                {
                  icon = " ";
                  key = "f";
                  desc = "Find File          ";
                  action = "Yazi";
                  key_format = " %s";
                }
                {
                  icon = " ";
                  key = "n";
                  desc = "New File                   ";
                  action = "ene | startinsert";
                  key_format = " %s";
                }
                {
                  icon = " ";
                  key = "g";
                  desc = "Find Text                   ";
                  action = "lua Snacks.dashboard.pick('live_grep')";
                  key_format = " %s";
                }
                {
                  icon = " ";
                  key = "r";
                  desc = "Recent Files                   ";
                  action = "lua Snacks.dashboard.pick('oldfiles')";
                  key_format = " %s";
                }
                {
                  icon = " ";
                  key = "s";
                  desc = "Restore Session                   ";
                  section = "session";
                  key_format = " %s";
                }
                {
                  icon = " ";
                  key = "q";
                  desc = "Quit                   ";
                  action = ":qa";
                  key_format = " %s";
                }
              ];
            };
          };
        };
      };
    };
  };
}
