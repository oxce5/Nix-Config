{
  unify.modules.server = {
    nixos = {pkgs, ...}: {
    };
    home = {pkgs, ...}: {
      home.packages = with pkgs; [
        neovim
        distant
      ];
    };
  };
}
