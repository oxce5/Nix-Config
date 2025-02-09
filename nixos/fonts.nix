{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nerdfonts
  ];
}
