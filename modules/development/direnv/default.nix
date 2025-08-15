{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    package = pkgs.unstable.direnv;
    nix-direnv = {
      enable = true;
    };
    enableZshIntegration = true;
    enableBashIntegration = true;
    loadInNixShell = true;
  };
}
