{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./ghostty
    ./mangohud
    ./ignis
    ./nvim
    ./cursors
    ./yazi
    ./wofi
    ./mako
    ./shell
  ];

  home.packages = with pkgs; [
    # (import ./kurukuru {
    #   inherit symlinkJoin makeWrapper runCommandLocal quickshell kdePackages lib;
    #   makeFontsConf = pkgs.makeFontsConf;
    #   nerd-fonts = pkgs.nerd-fonts.caskaydia-mono;
    #   material-symbols = pkgs.material-symbols;
    #   configPath = ./kurukuru/kurukurubar;
    #   asGreeter = false;
    #   customColors = null;
    # })
    # inputs.zaphkiel.packages.${pkgs.system}.kurukurubar-unstable
  ];

  cursor = "teto_cursor";
}
