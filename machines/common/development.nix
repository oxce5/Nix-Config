{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    devenv
    distrobox
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    loadInNixShell = true;
  };

  virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
