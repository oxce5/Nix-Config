{inputs, ...}: {
  unify.modules.neovim = {
    home = {...}: {
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
        autopairs.nvim-autopairs.enable = true;
        lazy.enable = true;
        mini.ai = {enable = true;};
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
