{
  imports = [./hyde.nix];

  hydenix.hm = {
    #! Important options
    enable = true;

    /*
    ! Below are defaults
    */
    comma.enable = true; # useful nix tool to run software without installing it first
    dolphin.enable = false; # file manager
    editors = {
      enable = true; # enable editors module
      vscode = {
        enable = false; # enable vscode module
        wallbash = true; # enable wallbash extension for vscode
      };
      default = "nvim"; # default text editor
    };

    fastfetch.enable = true; # fastfetch configuration
    firefox = {
      enable = false; # enable firefox module
    };
    git = {
      enable = true; # enable git module
      name = "oxce5"; # git user name eg "John Doe"
      email = "avg.gamer@proton.me"; # git user email eg "john.doe@example.com"
    };
    hyde.enable = false; # enable hyde module
    notifications.enable = true; # enable notifications module
    qt.enable = true; # enable qt module
    rofi.enable = true; # enable rofi module
    screenshots = {
      enable = true; # enable screenshots module
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = false; # enable satty screenshot annotation tool
      swappy.enable = true; # enable swappy screenshot editor
    };
    shell = {
      enable = true; # enable shell module
      zsh.enable = true; # enable zsh shell
      zsh.configText = ''
      ''; # zsh config text
      zsh.plugins = ["sudo"];
      bash.enable = false; # enable bash shell
      fish.enable = false; # enable fish shell
      pokego.enable = true; # enable Pokemon ASCII art scripts
      p10k.enable = false; # enable p10k prompt
      starship.enable = false; # enable starship prompt
    };
    social = {
      enable = false; # enable social module
      discord.enable = false; # enable discord module
      webcord.enable = false; # enable webcord module
      vesktop.enable = false; # enable vesktop module
    };
    spotify.enable = false; # enable spotify module
    swww.enable = true; # enable swww wallpaper daemon
    terminals = {
      enable = false; # enable terminals module
      kitty.enable = false; # enable kitty terminal
      kitty.configText = "";
    };
    theme = {
      enable = true; # enable theme module
      active = ""; # active theme name
      themes = [
        "Oxo Carbon"
        "Tokyo Night"
        "BlueSky"
      ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
    };
    waybar.enable = false; # enable waybar module
    wlogout.enable = true; # enable wlogout module
    xdg.enable = true; # enable xdg module
  };
}
