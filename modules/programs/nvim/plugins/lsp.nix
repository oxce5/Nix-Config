{
  self,
  inputs,
  ...
}: {
  unify.modules.neovim = {
    home = {
      pkgs,
      config,
      lib,
      ...
    }: let
      # Temporarily deprecated due to upstream issue
      # java-debug = pkgs.callPackage ./java-debug.nix {};
      java-debug = ./com.microsoft.java.debug.plugin-0.53.2.jar;
      vimPlug = pkgs.vimPlugins;
      inherit (inputs.nvf.lib.nvim.dag) entryAfter;
    in {
      programs.nvf.settings.vim = {
        extraPackages = [];

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
        formatter = {
          conform-nvim.enable = true;
        };

        extraPlugins = {
          nvim-jdtls = {
            package = vimPlug.nvim-jdtls;
            setup = ''
              local jdtls_share = '${pkgs.jdt-language-server}/share/java/jdtls'

              -- Glob any launcher jar, don't hardcode version
              local pattern = jdtls_share .. "/plugins/org.eclipse.equinox.launcher_*.jar"
              local matches = vim.fn.glob(pattern, false, true)
              local launcher_jar = matches[1]

              if not launcher_jar then
                vim.notify("jdtls: launcher jar not found!", vim.log.levels.ERROR)
                return
              end

              local config_dir = vim.fn.stdpath('cache') .. '/jdtls/config_linux'
              local project_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
              local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. project_dir

              local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
              extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

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

                root_dir = vim.fs.dirname(
                  vim.fs.find(
                    { 'pom.xml', 'gradlew', '.git', 'mvnw', '.classpath' },
                    { upward = true }
                  )[1]
                ),

                settings = {
                  java = {
                    signatureHelp = { enabled = true },

                    completion = {
                      favoriteStaticMembers = {},
                      overwrite = false,
                      guessMethodArguments = true,
                    },

                    contentProvider = {
                      preferred = 'fernflower',
                    },

                    codeGeneration = {
                      generateComments = true,
                      useBlocks = true,
                    },

                    inlayHints = {
                      parameterNames = {
                        enabled = "all",
                        exclusions = { "this" },
                      },
                      variableTypes = { enabled = true },
                      lambdaParameterTypes = { enabled = true },
                    },
                  },
                },

                init_options = {
                  bundles = debugBundles,
                  extendedClientCapabilities = extendedClientCapabilities,
                },
              }

              vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function(args)
                  require('jdtls').start_or_attach(config)
                  vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                end,
              })
            '';
          };
        };
      };
    };
  };
}
