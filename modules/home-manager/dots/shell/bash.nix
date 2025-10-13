{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.dots.shells.enableBash {
    programs.bash.enable = true;
  };
}
