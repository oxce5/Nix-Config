{ inputs, config, lib, pkgs, ...}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      reddit
    ];
    theme = {
      name = "Tokyo-Night";
      src = pkgs.fetchFromGitHub {
        owner = "evening-hs";
        repo = "Spotify-Tokyo-Night-Theme";
        rev = "main";
        hash = "sha256-cLj9v8qtHsdV9FfzV2Qf4pWO8AOBXu51U/lUMvdEXAk=";
      };
    };
    colorScheme = "Night";
  };
}
