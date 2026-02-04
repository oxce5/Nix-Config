{inputs, ...}: {
  unify.modules.workstation.home = {pkgs, ...}: {
    imports = [inputs.zen-browser.homeModules.default];
    programs.zen-browser.enable = false;
    home.packages = with pkgs; [
      brave
      inputs.helium.packages.${system}.default
    ];

    home.sessionVariables.BROWSER = "helium";
    # xdg.desktopEntries.zen-beta = {
    #   name = "Zen Browser (Beta)";
    #   icon = "zen-beta";
    #   genericName = "Web Browser";
    #   categories = [
    #     "Network"
    #     "WebBrowser"
    #   ];
    #   mimeType = [
    #     "text/html"
    #     "text/xml"
    #     "application/xhtml+xml"
    #     "x-scheme-handler/http"
    #     "x-scheme-handler/https"
    #     "application/x-xpinstall"
    #     "application/pdf"
    #     "application/json"
    #   ];
    #   exec = "zen-beta %u";
    #   actions = {
    #     new-window = {
    #       name = "New Window";
    #       exec = "zen-beta --new-window %U";
    #     };
    #     new-private-window = {
    #       name = "New Private Window";
    #       exec = "zen-beta --private-window %U";
    #     };
    #     profile-manager-window = {
    #       name = "Profile Manager";
    #       exec = "zen-beta --ProfileManager";
    #     };
    #   };
    # };
  };
}
