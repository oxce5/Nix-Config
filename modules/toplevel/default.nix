{
  unify.nixos = {
    pkgs,
    lib,
    homeConfig,
    ...
  }: {
    environment = {
      binsh = "${pkgs.dash}/bin/dash";
      # fixes some issues, mainly root $PATH
      systemPackages = homeConfig.home.packages;
      defaultPackages = lib.mkForce [];
    };
    zramSwap.enable = true;
    documentation = {
      man.generateCaches = lib.mkForce false;
      doc.enable = false;
      info.enable = false;
    };
    time.timeZone = "Asia/Manila";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = ["all"];
    system.stateVersion = "22.05";
  };
}
