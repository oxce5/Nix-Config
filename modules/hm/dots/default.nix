{
pkgs, 
symlinkJoin, 
makeWrapper, 
lib, 
...
}:

{
  imports = [
    ./hyde
    ./hypr
    ./mangohud
    ./nvim
    ./ricecursor
    ./yazi
    ./zsh
  ];

  home.packages = with pkgs; [
    (import ./kurukuru {
      inherit symlinkJoin makeWrapper quickshell kdePackages lib;
      makeFontsConf = pkgs.makeFontsConf;
      nerd-fonts = pkgs.nerd-fonts.caskaydia-mono;
      material-symbols = pkgs.material-symbols;
    })
  ];
}
