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

        lsp.enable = true;
        languages = {
          enableTreesitter = true;

          nix.enable = true;
          python.enable = true;
        };

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
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
        mini.ai = {enable = true;};

        assistant = {
          avante-nvim = {
            enable = true;
            setupOpts = {
              # Set GitHub Copilot as the main provider
              provider = "copilot";
              auto_suggestions_provider = "copilot";
              behaviour = {
                auto_suggestions = true;
                enable_token_counting = true;
              };
              suggestion = {
                debounce = 900; # Default was 600
                throttle = 800; # Default was 600
              };
              windows = {
                position = "right";
                width = 30;
                wrap = true;
              };
            };
          };
          copilot.enable = true;
        };

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
          yanky-nvim.enable = false;
          yazi-nvim = {
            enable = true;
          };
        };

        visuals.indent-blankline.enable = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
          autoindent = true;
        };

        keymaps = [
          {
            key = "<leader>e";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('snacks.explorer').open()<CR>";
          }
        ];

        luaConfigRC.tab = ''
          vim.opt.expandtab = true
          vim.opt.smartindent = true
          vim.opt.clipboard = "unnamedplus"
        '';
      };
    };
  };
}
