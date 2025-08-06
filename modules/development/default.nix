{pkgs, ...}: {
  imports = [
    ./direnv
  ];

  environment.systemPackages = [pkgs.devenv];
}
