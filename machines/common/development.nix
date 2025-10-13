{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    devenv
    distrobox

    eclipses.eclipse-java
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    loadInNixShell = true;
  };

  virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };
}
