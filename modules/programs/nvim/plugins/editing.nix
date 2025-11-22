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
        binds.whichKey.enable = true;
        autopairs.nvim-autopairs = {
          enable = true;
          setupOpts = {
            map_bs = false;
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
          surround.enable = true;
          snacks-nvim = {
            enable = true;
          };
          yanky-nvim.enable = false;
          yazi-nvim = {
            enable = true;
          };
          motion.leap.enable = true;
        };
      };
    };
  };
}
