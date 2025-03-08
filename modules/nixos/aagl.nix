{ inputs, ... }:

{
  imports = [ inputs.aagl.nixosModules.default ];
  nix.settings = inputs.aagl.nixConfig;
  programs.anime-game-launcher.enable = false;
  programs.anime-games-launcher.enable = false;
  programs.honkers-railway-launcher.enable = true;
  programs.honkers-launcher.enable = false;
  programs.wavey-launcher.enable = false;
  programs.sleepy-launcher.enable = false;
}

