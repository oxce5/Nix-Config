{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    enableManpages = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
          transparent = true;
        };

        lsp.enable = true;
        languages = {
          enableTreesitter = true;

          nix.enable = true;
          python.enable = true;
          java.enable = true;
          ts.enable = true;
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

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        binds.whichKey.enable = true;
        tabline.nvimBufferline.enable = true;
        notify.nvim-notify.enable = true;
        ui.noice.enable = true;
        autopairs.nvim-autopairs.enable = true;
        lazy.enable = true;
        mini.ai = {enable = true;};

        assistant = {
          avante-nvim = {
            enable = true;
            setupOpts = {
              provider = "copilot";
              auto_suggestions_provider = "copilot";
              behaviour = {
                auto_suggestions = true;
                enable_token_counting = true;
              };
              suggestion = {
                debounce = 900; # Default was 600
                throttle = 800; # Default was 600
              };
              windows = {
                position = "right";
                width = 30;
                wrap = true;
              };
            };
          };
          copilot.enable = true;
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
        };

        visuals.indent-blankline.enable = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
          autoindent = true;
        };

        keymaps = [
          {
            key = "<leader>e";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('snacks.explorer').open()<CR>";
          }
        ];

        luaConfigRC.tab = ''
          vim.opt.expandtab = true
          vim.opt.smartindent = true
          vim.opt.clipboard = "unnamedplus"

          vim.api.nvim_create_autocmd({ "CursorHold" }, {
            callback = function()
              local opts = { focusable = false }
              local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
              local col = vim.fn.col('.') - 1
              for _, diag in ipairs(diagnostics) do
                if diag.col <= col and col < diag.end_col then
                  vim.diagnostic.open_float(nil, opts)
                  return
                end
              end
            end,
          })
        '';
        extraPlugins = {
          nvim-jdtls = {
            package = pkgs.vimPlugins.nvim-jdtls;
            setup = ''
              local jdtls_share = '${pkgs.jdt-language-server}/share/java/jdtls'
              local launcher_jar = vim.fn.glob(jdtls_share .. '/plugins/org.eclipse.equinox.launcher_*.jar')
              local config_dir = vim.fn.stdpath('cache') .. '/jdtls/config_linux'
              local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace'
              -- Add java-debug jar
              local bundles = {
                "/home/oxce5/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.2.jar",
              }
              -- Add vscode-java-test jars
              vim.list_extend(
                bundles,
                vim.split(vim.fn.glob("/home/oxce5/vscode-java-test/server/*.jar", 1), "\n")
              )
              require('jdtls').start_or_attach({
                cmd = {
                  '$(echo $JAVA_HOME)',
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
                root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', 'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
                settings = {
                  java = {
                    signatureHelp = { enabled = true },
                    completion = { favoriteStaticMembers = {} },
                    contentProvider = { preferred = 'fernflower' },
                    extendedClientCapabilities = require('jdtls').extendedClientCapabilities
                  }
                },
                init_options = {
                  bundles = bundles
                }
              })

              vim.list_extend(
                bundles,
                vim.split(vim.fn.glob("/home/oxce5/vscode-java-test/server/*.jar", 1), "\n")
              )
            '';
          };
        };
      };
    };
  };
}
