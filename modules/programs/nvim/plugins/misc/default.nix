{
  unify.modules.neovim = {
    home = {pkgs, ...}: let
      vimPlug = pkgs.vimPlugins;
    in {
      programs.nvf.settings.vim.extraPlugins = {
        no-neck-pain.package = vimPlug.no-neck-pain-nvim;
        firenvim = {
          package = vimPlug.firenvim;
          setup = ''
            vim.g.firenvim_config = {
              localSettings = {
                -- allow only this domain
                [ [[.*umindanao\.codechum\.com.*]] ] = {
                  takeover = "always",
                  priority = 10,
                },

                -- everything else: no takeover
                [ [[.*]] ] = {
                  takeover = "never",
                  priority = 0,
                },
              },
            }
          '';
        };
        distant.package = vimPlug.distant-nvim;
        keys-nvim = {
          package = pkgs.vimUtils.buildVimPlugin {
            pname = "screenkey-nvim";
            version = "main";
            src = pkgs.fetchFromGitHub {
              owner = "NStefan002";
              repo = "screenkey.nvim";
              rev = "main";
              hash = "sha256-hVpIWF9M8Ef7Ku02hti1JS4e1vHwNk3gY9+1VZ6DB20=";
            };
          };
        };
      };
    };
  };
}
