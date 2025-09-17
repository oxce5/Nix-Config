# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  #   additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  #   modifications = final: prev: {
  #     # example = prev.example.overrideAttrs (oldAttrs: rec {
  #     # ...
  #     # });
  #   };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: super: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
    fix = import inputs.nixpkgs-fix-nvidia {
      system = final.system;
      config.allowUnfree = true;
    };
    youtube-music = super.youtube-music.overrideAttrs (old: rec {
      version = "master";
      src = super.fetchFromGitHub {
        owner = "th-ch";
        repo = "youtube-music";
        rev = "master";
        hash = "sha256-+2hM98j7IO1LuGwdt+YItDz4dE4cFc3qabZM/Mrtyis=";
      };
      pnpmDeps = super.pnpm.fetchDeps {
        pname = "youtube-music";
        version = "master";
        src = src;
        fetcherVersion = 1;
        hash = "sha256-F7+3Tve0jT2Z4BBDlbx8FdyMINqNaf2oJP9qCZJ1y48=";
      };
    });
  };
  nixpkgs.overlays = [
    inputs.niri-flake.overlays.niri
  ];
}
