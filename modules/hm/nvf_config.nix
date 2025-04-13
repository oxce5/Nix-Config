{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    enableManpages = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
          transparent = true;
        };

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          python.enable = true;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        binds.whichKey.enable = true;
        tabline.nvimBufferline.enable = true;
        notify.nvim-notify.enable = true;
        ui.noice.enable = true;
        autopairs.nvim-autopairs.enable = true;
        lazy.enable = true;

        utility = {
          surround.enable = true;
          snacks-nvim = {
            enable = true;
            setupOpts = {
              explorer = {
                replace_netrw = true;
              };
              picker = {
                sources = {
                  explorer = {};
                };
              };
            };
          };
          yanky-nvim.enable = true;
          yazi-nvim = {
            enable = true;
          };
        };

        options = {
          tabstop = 2;
          shiftwidth = 2;
          autoindent = true;
        };

        keymaps = [
          {
            key = "<leader>m";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('snacks.explorer').open()<CR>";
          }
        ];

        luaConfigRC.tab = ''
          vim.opt.expandtab = true
          vim.opt.smartindent = true
        '';
      };
    };
  };
}
