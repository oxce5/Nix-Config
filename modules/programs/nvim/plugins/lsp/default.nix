{ self, inputs, ... }: {
  unify.modules.neovim = {
    home = { pkgs, lib, ... }: let
      vimPlug = pkgs.vimPlugins;
    in {
      programs.nvf.settings.vim = {
        treesitter = {
          enable = true;
          context.enable = true;
          autotagHtml = true;
          fold = true;
          textobjects.enable = true;
        };

        lsp = {
          enable = true;
          trouble.enable = true;
          lspkind.enable = true;
          inlayHints.enable = true;
          lightbulb.enable = true;
        };

        languages = {
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          enableFormat = true;

          nix.enable = true;
          python.enable = true;
          clang.enable = true;
          java.enable = true;
          ts.enable = true;
          php.enable = true;
        };

        debugger.nvim-dap = {
          enable = true;
          ui.enable = true;
        };

        diagnostics = {
          enable = true;
          nvim-lint.enable = true;
          config = {
            update_in_insert = true;
            signs.text = lib.generators.mkLuaInline ''
              {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = "󰀪 ",
                [vim.diagnostic.severity.INFO] = " ",
              }
            '';
            virtual_lines = false;
            virtual_text = false;
          };
        };

        lazy.plugins = {
          "better-diagnostics-virtual-text" = {
            package = pkgs.vimUtils.buildVimPlugin {
              pname = "better-diagnostics-virtual-text";
              version = "master";
              src = pkgs.fetchFromGitHub {
                owner = "sontungexpt";
                repo = "better-diagnostic-virtual-text";
                rev = "main";
                hash = "sha256-x6DYr+w0FIwVgrXgip8/wSrUDqkRkAs5HxXdwjY76/I=";
              };
            };
            setupModule = "better-diagnostic-virtual-text";
            event = ["LspAttach"];
            after = ''
              require('better-diagnostic-virtual-text').setup(opts)
            '';
            setupOpts = {
              ui = {
                wrap_line_after = false;
                left_kept_space = 3;
                right_kept_space = 3;
                arrow = "  ";
                up_arrow = "  ";
                down_arrow = "  ";
                above = false;
              };
              priority = 2003;
              inline = false;
            };
          };
        };

        formatter.conform-nvim.enable = true;
      };
    };
  };
}
