{inputs, ...}: {
  unify.modules.neovim = {
    home = {pkgs, ...}: let
      vimPlug = pkgs.vimPlugins;
    in {
      programs.nvf.settings.vim = {
        extraplugins = {
          no-neck-pain.package = vimPlug.no-neck-pain-nvim;
          firenvim.package = vimPlug.firenvim;
        };
      };
    };
  };
}
