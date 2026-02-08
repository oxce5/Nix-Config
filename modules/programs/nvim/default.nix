{inputs, ...}: {
  unify.modules.neovim = {
    home = {
      pkgs,
      config,
      lib,
      ...
    }: let
      inherit (inputs.nvf.lib.nvim.dag) entryAfter;
    in {
      imports = [inputs.nvf.homeManagerModules.default];
      programs.nvf = {
        enable = true;
        enableManpages = true;
      };
    };
  };
}
