{pkgs}: {
  imports = [
    ./direnv
  ];

  home.packages = [pkgs.devenv];
}
