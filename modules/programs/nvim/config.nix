{
  unify.modules.neovim.home = {pkgs, ...}: {
    home = {
      packages = [pkgs.jdt-language-server];
      file.".cache/nvf/jdtls/config_linux/config.ini" = {
        source = "${pkgs.jdt-language-server}/share/java/jdtls/config_linux/config.ini";
        force = true;
      };
    };
  };
}
