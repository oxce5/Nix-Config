{inputs, ...}: {
  unify.modules.neovim = {
    home = {lib, ...}: {
      programs.nvf.settings.vim = {
        options = {
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;
          autoindent = true;
          smartindent = true;
          wrap = false;

          swapfile = false;
          backup = false;
          undofile = true;

          incsearch = true;
          inccommand = "split";
          ignorecase = true;
          smartcase = true;

          termguicolors = true;
          scrolloff = 8;
          signcolumn = "yes";

          splitbelow = true;
          updatetime = 50;

          showcmd = true;
          expandtab = true;
        };

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };

        highlight = {
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

        luaConfigRC.optionsScript = ''
          vim.o.foldcolumn = 'auto:9'
          vim.o.foldlevel = 99
          vim.o.foldlevelstart = 99
          vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep:▏,foldclose:'
        '';
      };
    };
  };
}
