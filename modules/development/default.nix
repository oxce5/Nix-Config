{pkgs, ...}: {
  imports = [
    ./direnv
  ];

  environment.systemPackages = [pkgs.unstable.devenv];
}
