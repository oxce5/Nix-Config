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
      java-debug = builtins.toString ./com.microsoft.java.debug.plugin-0.53.2.jar;
      vimPlug = pkgs.vimPlugins;
      # inherit (inputs.nvf.lib.nvim.dag) entryAfter;
    in {
      imports = [inputs.nvf.homeManagerModules.default];
      programs.nvf = {
        enable = true;
        enableManpages = true;
        # your settings need to go into the settings attribute set
        # most settings are documented in the appendix
        settings = {
          vim = {
            luaConfigRC = {
              transparentTheme = ''
                 vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                 vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
                 vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
                 vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
                vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none"  })
                vim.api.nvim_set_hl(0, "LineNr", { bg = "none"  })
              '';
              tab = ''
                vim.opt.expandtab = true
                vim.opt.smartindent = true
                vim.opt.clipboard = "unnamedplus"
              '';
              pluginConfigs = ''
                local hooks = require "ibl.hooks"
                hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
                end)

                vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#e06c75", bg = "#000000" })
                vim.api.nvim_set_hl(0, "NotifyBackground", { fg = "#000000", bg = "#000000" })
              '';
              optionsScript = ''
                vim.o.foldcolumn = 'auto:9'
                vim.o.foldlevel = 99
                vim.o.foldlevelstart = 99
                vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep:▏,foldclose:'
              '';
            };

            autocmds = [
              {
                event = ["CursorHold"];
                desc = "Open diagnostic hover on CursorHold";
                callback = lib.generators.mkLuaInline ''
                  function()
                    local opts = { focusable = false }
                    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
                    local col = vim.fn.col('.') - 1
                    for _, diag in ipairs(diagnostics) do
                      if diag.col <= col and col < diag.end_col then
                        vim.diagnostic.open_float(nil, opts)
                        return
                      end
                    end
                  end
                '';
              }
              {
                event = ["FileType"];
                pattern = ["dashboard"];
                desc = "Attach and disable folding for dashboard file type";
                callback = lib.generators.mkLuaInline ''
                  function()
                    require("ufo").detach()
                    vim.opt_local.foldenable = false
                  end
                '';
              }
              {
                event = ["VimEnter"];
                desc = "Toggle Avante's suggestions (FIX FOR COPILOT.LUA PLENARY DEPENDENCY)";
                callback = lib.generators.mkLuaInline ''
                      function()
                        local h = io.popen("ping -c 1 8.8.8.8")
                        local r = h:read("*a")
                        h:close()
                        if not r:find("1 received") then
                    require("avante").toggle.suggestion()
                    vim.notify("Offline! avante suggestions are off.", vim.log.levels.WARN)
                  end
                              end
                '';
              }
            ];

            keymaps = [
              {
                key = "<leader>q";
                mode = "n";
                silent = true;
                action = "vi\"";
                noremap = true;
              }
            ];
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

            clipboard = {
              enable = true;
              providers.wl-copy.enable = true;
            };

            statusline.lualine.enable = true;
            telescope.enable = true;
            autocomplete = {
              blink-cmp = {
                enable = true;
                friendly-snippets.enable = true;
                setupOpts.keymap = {
                  preset = "none";
                };
              };
            };
            binds.whichKey.enable = true;
            tabline.nvimBufferline.enable = true;
            notify.nvim-notify.enable = true;
            ui = {
              noice.enable = true;
              nvim-ufo = {
                enable = true;
                setupOpts = {};
              };
            };

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
              motion.leap.enable = true;
            };
            terminal.toggleterm = {
              lazygit.enable = true;
            };

            visuals.indent-blankline = {
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

            dashboard.dashboard-nvim = {
              enable = true;
              setupOpts = {
                theme = "doom";
                config = {
                  header = [
                    "                                                                       "
                    "                                      ██████                           "
                    "                                  ████    ██                           "
                    "                                  ██      ██                           "
                    "                                  ██      ██                           "
                    "                                  ██    ████                           "
                    "                                ████    ████      ██                   "
                    "                                ████            ██  ██    ██           "
                    "                            ██                  ██  ██  ██  ██         "
                    "                          ██                  ██      ██    ██         "
                    "                        ████                  ██            ██         "
                    "                        ████                ██              ██         "
                    "         ██████████     ████  ████████████  ██              ██         "
                    "         ███████████     ███  ████████████  ██              ██         "
                    "       ██████████████     ████████████████████    ██      ██████       "
                    "         █████████████████████████████████████  ██      ██████         "
                    "     ███████████████████████████████████████████      ████████████     "
                    "     █████████████████████████████████████████████████████████████     "
                    "     █████████████████████████████████████████████████████████████     "
                    "         █████████████████████████████████████████████████████         "
                    "     █████████████████████████████████████████████████████████████     "
                    "     ███████████████████████  ████████████  ██████████████████████     "
                    "     █████████████████████      ████████      ████████████████████     "
                    "     ████████████████████       ████████      ████████████████████     "
                    "         ██████████████           ████          ██████████████         "
                    "       ████████████████     ██            ██    ████████████████       "
                    "       ██████████████     ██  ██        ██  ██    ██████████████       "
                    "       ██████████████     ██  ██        ██  ██    ██████████████       "
                    "           ████████████                         ████████████           "
                    "         ████████████████   ██            ██    ██████████████         "
                    "           ██████  ████       ████████████    ██████  ██████           "
                    "           ██████    ██       ██        ██      ██    ██████           "
                    "             ████      ██       ██    ██      ██      ████             "
                    "               ██        █████    ████    ████        ██               "
                    "                              ████████████                             "
                    "                                                                       "
                    "                                                                       "
                    "                                                                       "
                  ];
                };
              };
            };

            options = {
              tabstop = 2;
              shiftwidth = 2;
              autoindent = true;
            };

            # keymaps = [
            # ];

            extraPlugins = {
              nvim-jdtls = {
                package = vimPlug.nvim-jdtls;
                setup = ''
                  local jdtls_share = '${pkgs.jdt-language-server}/share/java/jdtls'
                  local launcher_jar = '${pkgs.jdt-language-server}/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar'
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
              no-neck-pain = {
                package = vimPlug.no-neck-pain-nvim;
                # setup = ''
                #
                # '';
              };
            };
          };
        };
      };
    };
  };
}
