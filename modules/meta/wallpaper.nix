{lib, ...}: {
  unify.options.primaryWallpaper = lib.mkOption {
  type = lib.types.nullOr (lib.types.either lib.types.path lib.types.package);
  default = null;
}

