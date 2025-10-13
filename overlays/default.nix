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
    # unstable = import inputs.nixpkgs-unstable {
    #   system = final.system;
    #   config.allowUnfree = true;
    # };
    # fix = import inputs.nixpkgs-fix-nvidia {
    #   system = final.system;
    #   config.allowUnfree = true;
    # };
    youtube-music = super.youtube-music.overrideAttrs (old: rec {
      version = "master";
      src = super.fetchFromGitHub {
        owner = "th-ch";
        repo = "youtube-music";
        rev = "c9ae7cb27769820fd5cedb70e70a83557c81e270";
        hash = "sha256-mxS09NrkExlDW3CSl560BSEModBcNZ/8TnsFpsTIghw=";
      };
      pnpmDeps = super.pnpm.fetchDeps {
        pname = "youtube-music";
        version = "master";
        src = src;
        fetcherVersion = 1;
        hash = "sha256-F7+3Tve0jT2Z4BBDlbx8FdyMINqNaf2oJP9qCZJ1y48=";
      };
    });
    zjstatus = inputs.zjstatus.packages.${final.system}.default;
  };

  winboat-overlay = final: super: {
    # Use oldAttrs.version inside overrideAttrs and the correct system field
    winboat = inputs.winboat.packages.${final.system}.winboat.overrideAttrs (oldAttrs: rec {
      version = "0.8.5";
      src = final.fetchurl {
        url = "https://github.com/TibixDev/winboat/releases/download/v${version}/winboat-${version}-x64.tar.gz";
        sha256 = "1mvvd6y0wcpqh6wmjzpax7pkdpwcibhb9y7hnrd7x79fr0s5f3mp";
      };
    });
  };
}
