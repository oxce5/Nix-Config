{
  self,
  inputs,
  ...
}: {
{ self, inputs, ... }: {
  unify.modules.neovim = {
    home = { pkgs, ... }: let
      java-debug = ../../resources/java-debug/com.microsoft.java.debug.plugin-0.53.2.jar;
      vimPlug = pkgs.vimPlugins;
    in {
      programs.nvf.settings.vim.extraPlugins.nvim-jdtls = {
        package = vimPlug.nvim-jdtls;
        setup = ''
          local jdtls_share = '${pkgs.jdt-language-server}/share/java/jdtls'

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

                contentProvider = { preferred = 'fernflower' },

                codeGeneration = {
                  generateComments = true,
                  useBlocks = true,
                },

                inlayHints = {
                  parameterNames = { enabled = "all", exclusions = { "this" } },
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
}
