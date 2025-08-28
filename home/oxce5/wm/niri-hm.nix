{inputs, outputs, pkgs, ...}:

let 
  swww = inputs.swww.packages.${pkgs.system}.swww;
in{
  imports = [ ];

  home.file.".config/niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
    mutable = true;
  };

  home.packages = with pkgs; [
    xwayland-satellite
    alacritty
    mako
    swww
  ];

  services = {
    swayidle = {
      enable = true;
    };
  };
}
