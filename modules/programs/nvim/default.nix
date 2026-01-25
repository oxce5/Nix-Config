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
        settings.vim = {
          theme = {
            enable = true;
            style = "dark";
            name = "gruvbox";
            transparent = true;
          };
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
            softtabstop = 2;
            autoindent = true;
            showcmd = true;
            expandtab = true;
            smartindent = true;
          };
          highlight = let
            bgNone = names: lib.genAttrs names (_: {bg = "none";});
          in
            (bgNone [
              "Normal"
              "NormalNC"
              "SignColumn"
              "VertSplit"
              "StatusLine"
              "StatusLineNC"
              "LineNr"
              "CursorLineNr"
              "TelescopeNormal"
              "TelescopeBorder"
              "FoldColumn"
              "Folded"
            ])
            // {
              DashboardHeader.fg = "#e06c75";
              NotifyBackground = {
                fg = "#000000";
                bg = "#000000";
              };
              RainbowRed.fg = "#E06C75";
              RainbowYellow.fg = "#E5C07B";
              RainbowBlue.fg = "#61AFEF";
              RainbowOrange.fg = "#D19A66";
              RainbowGreen.fg = "#98C379";
              RainbowViolet.fg = "#C678DD";
              RainbowCyan.fg = "#56B6C2";
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
          ];

          luaConfigRC = {
            optionsScript = ''
              vim.o.foldcolumn = 'auto:9'
              vim.o.foldlevel = 99
              vim.o.foldlevelstart = 99
              vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep:▏,foldclose:'
            '';
            pluginConfigs = ''
              local npairs = require'nvim-autopairs'
              local Rule = require'nvim-autopairs.rule'
              local cond = require 'nvim-autopairs.conds'

            '';
          };
        };
      };
    };
  };
}
