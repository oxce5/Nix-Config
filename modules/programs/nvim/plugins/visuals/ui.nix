{
  unify.modules.neovim = {
    home = {
      programs.nvf.settings.vim = {
        telescope.enable = true;
        notify.nvim-notify.enable = true;
        terminal.toggleterm = {
          lazygit.enable = true;
        };

        notes = {
          todo-comments.enable = true;
        };
      };
    };
  };
}
