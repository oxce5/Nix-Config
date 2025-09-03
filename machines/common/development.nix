{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    devenv
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    loadInNixShell = true;
  };
}
