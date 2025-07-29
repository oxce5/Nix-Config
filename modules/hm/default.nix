{
  inputs,
  ...
}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    inputs.zen-browser.homeModules.twilight
    inputs.impermanence.homeManagerModules.impermanence

    ./dots
    ./packages
    ./programs
    ./symlink.nix
  ];

  # home-manager options go here/
  services = {
    podman.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/roblox-player" = ["org.vinegarhq.Sober.desktop"];
    };
  };

  home.persistence."/persistent" = {
    directories = [
      ".zen"
    ];
  };

  home.sessionVariables = {
    BATTERY_NOTIFY_EXECUTE_UNPLUG = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1";
    BATTERY_NOTIFY_EXECUTE_DISCHARGING = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1";
    BATTERY_NOTIFY_EXECUTE_CHARGING = "hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1";
    TERMINAL = "ghostty";
  };
}
