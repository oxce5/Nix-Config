{inputs, ...}: {
  unify.modules.neovim = {
    home = {...}: {
      programs.nvf.settings.vim = {
        binds = {
          hardtime-nvim.enable = true;
          whichKey.enable = true;
        };
      };
    };
  };
}
