{inputs, ...}: {
  unify.modules.neovim = {
    home = {
      pkgs,
      config,
      lib,
      ...
    }: let
      inherit (inputs.nvf.lib.nvim.dag) entryAfter;
    in {
      imports = [inputs.nvf.homeManagerModules.default];
      programs.nvf = {
        enable = true;
        enableManpages = true;
        # your settings need to go into the settings attribute set
        # most settings are documented in the appendix
        settings.vim = {
          luaConfigRC = {
            transparentTheme = entryAfter ["theme"] ''
              local groups = {
                "Normal", "NormalNC", "SignColumn", "VertSplit",
                "StatusLine", "StatusLineNC", "LineNr", "CursorLineNr",
                "TelescopeNormal", "TelescopeBorder",
                "FoldColumn", "Folded"
              }
              vim.cmd("colorscheme base16-rose-pine-moon")

              for _, group in ipairs(groups) do
                vim.api.nvim_set_hl(0, group, { bg = "none" })
              end

              vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#e06c75" })
              vim.api.nvim_set_hl(0, "NotifyBackground", { fg = "#000000", bg = "#000000" })
            '';
            tab = ''
              vim.opt.expandtab = true
              vim.opt.smartindent = true
              vim.opt.clipboard = "unnamedplus"
            '';
            pluginConfigs = ''
              local hooks = require "ibl.hooks"
              hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
              end)
            '';
            optionsScript = ''
              vim.o.foldcolumn = 'auto:9'
              vim.o.foldlevel = 99
              vim.o.foldlevelstart = 99
              vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep:▏,foldclose:'
            '';
          };

          autocmds = [
            {
              event = ["CursorHold"];
              desc = "Open diagnostic hover on CursorHold";
              callback = lib.generators.mkLuaInline ''
                function()
                  local opts = { focusable = false }
                  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
                  local col = vim.fn.col('.') - 1
                  for _, diag in ipairs(diagnostics) do
                    if diag.col <= col and col < diag.end_col then
                      vim.diagnostic.open_float(nil, opts)
                      return
                    end
                  end
                end
              '';
            }
            {
              event = ["FileType"];
              pattern = ["dashboard"];
              desc = "Attach and disable folding for dashboard file type";
              callback = lib.generators.mkLuaInline ''
                function()
                  require("ufo").detach()
                  vim.opt_local.foldenable = false
                end
              '';
            }
            {
              event = ["VimEnter"];
              desc = "Toggle Avante's suggestions (FIX FOR COPILOT.LUA PLENARY DEPENDENCY)";
              callback = lib.generators.mkLuaInline ''
                    function()
                      local h = io.popen("ping -c 1 -W 1 8.8.8.8")
                      local r = h:read("*a")
                      h:close()
                      if not r:find("1 received") then
                  require("avante").toggle.suggestion()
                  vim.notify("Offline! avante suggestions are off.", vim.log.levels.WARN)
                end
                            end
              '';
            }
          ];

          keymaps = [
            {
              key = "<leader>q";
              mode = "n";
              silent = true;
              action = "vi\"";
              noremap = true;
            }
          ];

          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
          };

          options = {
            tabstop = 2;
            shiftwidth = 2;
            autoindent = true;
          };
        };
      };
    };
  };
}
