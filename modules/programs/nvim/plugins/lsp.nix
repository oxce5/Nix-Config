{inputs, ...}: {
  unify.modules.neovim = {
    home = {
      pkgs,
      config,
      lib,
      ...
    }: let
      # Temporarily deprecated due to upstream issue
      # java-debug = pkgs.callPackage ./java-debug.nix {};
      java-debug = builtins.toString ./java.debug.jar;
      vimPlug = pkgs.vimPlugins;
      # inherit (inputs.nvf.lib.nvim.dag) entryAfter;
    in {
      imports = [inputs.nvf.homeManagerModules.default];
      programs.nvf.settings.vim = {
        lsp.enable = true;
        lsp.trouble.enable = true;
        languages = {
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          python.enable = true;
          clang.enable = true;
          java = {
            enable = true;
            lsp.enable = false;
          };
          ts.enable = true;
          php = {
            enable = true;
          };
        };

        debugger.nvim-dap = {
          enable = true;
          ui.enable = true;
        };

        diagnostics = {
          enable = true;
          nvim-lint.enable = true;
        };
        formatter = {
          conform-nvim.enable = true;
        };

        extraPlugins = {
          nvim-jdtls = {
            package = vimPlug.nvim-jdtls;
            setup = ''
              local jdtls_share = '${pkgs.jdt-language-server}/share/java/jdtls'

              local pattern = jdtls_share .. "/plugins/org.eclipse.equinox.launcher_1.7.0.*.jar"
              local matches = vim.fn.glob(pattern, false, true)

              local launcher_jar = (#matches > 0) and matches[1] or nil

              local config_dir = vim.fn.stdpath('cache') .. '/jdtls/config_linux'
              local project_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
              local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace' .. project_dir
              -- Add java-debug jar
              local debugBundles = { "${java-debug}" }
              local config = {
                cmd = {
                  '${pkgs.jdk}/bin/java',
                  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                  '-Dosgi.bundles.defaultStartLevel=4',
                  '-Declipse.product=org.eclipse.jdt.ls.core.product',
                  '-Dlog.protocol=true',
                  '-Dlog.level=ALL',
                  '-Xms1G',
                  '-Xmx2G',
                  '-jar', launcher_jar,
                  '-configuration', config_dir,
                  '-data', workspace_dir,
                },
                root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', 'gradlew', '.git', 'mvnw', '.classpath'}, { upward = true })[1]),
                settings = {
                  java = {
                    signatureHelp = { enabled = true },
                    completion = { favoriteStaticMembers = {} },
                    contentProvider = { preferred = 'fernflower' },
                    extendedClientCapabilities = require('jdtls').extendedClientCapabilities
                  }
                },
                init_options = {
                  bundles = debugBundles
                }
              }

              vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function(args)
                  require('jdtls').start_or_attach(config)
                end
              })
            '';
          };
        };
      };
    };
  };
}
