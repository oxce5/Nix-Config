{inputs, ...}: {
  unify.modules.neovim = {
    home = {pkgs, ...}: {
      programs.nvf.settings.vim = {
        autocomplete = {
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            setupOpts.keymap = {
              preset = "none";
            };
          };
        };
        lazy.plugins = {
          "smart-backspace" = {
            package = pkgs.vimUtils.buildVimPlugin {
              pname = "smart-backspace";
              version = "master";
              src = pkgs.fetchFromGitHub {
                owner = "qwavies";
                repo = "smart-backspace.nvim";
                rev = "main";
                hash = "sha256-koQp1b5wTTTxQgifVfC90AQImLk0E40QSfihiNd1vVQ=";
              };
            };
            event = ["InsertEnter" "CmdlineEnter"];
            setupOpts = {
              enable = true;
              silent = true;
            };
          };
        };
        snippets = {
          luasnip.enable = true;
        };
        utility = {
          surround = {
            enable = true;
            setupOpts = {
              keymaps = {
                insert = "<C-g>s";
                insert_line = "<C-g>S";
                normal = "ys";
                normal_cur = "yss";
                normal_line = "yS";
                normal_cur_line = "ySS";
                visual = "S";
                visual_line = "gS";
                delete = "ds";
                change = "cs";
                change_line = "cS";
              };
            };
          };
          snacks-nvim = {
            enable = true;
          };
          yanky-nvim.enable = false;
          yazi-nvim = {
            enable = true;
          };
          motion = {
            flash-nvim = {
              enable = true;
              mappings = {
                jump = "f";
              };
            };
            precognition = {
              enable = true;
            };
          };
        };
      };
    };
  };
}
