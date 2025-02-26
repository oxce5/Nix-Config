{ config, lib, pkgs, ... }:

{
  virtualisation.containers.enable = true;
  virtualisation.waydroid.enable = true;
  # virtualisation.docker = {
  #     enable = true;
  #     # extraOptions = "--publish-all"; 
  #     rootless = {
  #         enable = true;
  #         setSocketVariable = true;
  #       };
  #   };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
