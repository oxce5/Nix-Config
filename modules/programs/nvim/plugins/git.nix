{
  unify.modules.neovim = {
    home = {pkgs, ...}: {
      programs.nvf.settings.vim = {
        git = {
          enable = true;
          gitsigns = {
            enable = true;
          };
        };
      };
    };
  };
}
