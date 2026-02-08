{
  unify.modules.neovim = {
    home = {
      programs.nvf = {
        vim.settings = {
          ui = {
            noice = {
              enable = true;
            };
            nvim-ufo = {
              enable = true;
              setupOpts = {};
            };
          };

          visuals = {
            indent-blankline = {
              enable = true;
              setupOpts = {
                indent = {
                  char = "";
                  priority = 36;
                };
                exclude = {
                  buftypes = [
                    "terminal"
                    "nofile"
                    "quickfix"
                    "prompt"
                    "dashboard"
                  ];
                  filetypes = [
                    "dashboard"
                  ];
                };
                scope = {
                  char = "▏";
                  show_exact_scope = true;
                  show_start = true;
                  show_end = true;
                  highlight = [
                    "RainbowRed"
                    "RainbowYellow"
                    "RainbowBlue"
                    "RainbowOrange"
                    "RainbowGreen"
                    "RainbowViolet"
                    "RainbowCyan"
                  ];
                };
              };
            };
            rainbow-delimiters.enable = true;
          };
        };
      };
    };
  };
}
