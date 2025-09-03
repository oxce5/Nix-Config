{
  outputs,
  pkgs,
  ...
}: {
  home.file.".cache/nvf/jdtls/config_linux/config.ini" = {
    source = "${pkgs.jdt-language-server}/share/java/jdtls/config_linux/config.ini";
    force = true;
    mutable = true;
  };
}
