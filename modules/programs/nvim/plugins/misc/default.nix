{
  unify.modules.neovim = {
    home = {pkgs, ...}: let
      vimPlug = pkgs.vimPlugins;
    in {
      programs.nvf.settings.vim = {
        presence.neocord = {
          enable = true;
        };
      };
    };
  };
}
