self: super: {
  youtube-music = super.youtube-music.overrideAttrs (old: rec {
    version = "master";
    src = super.fetchFromGitHub {
      owner = "th-ch";
      repo = "youtube-music";
      rev = "master";
      hash = "sha256-fzS4dLA0NAbBklbgITcqVA/2MLfXHCI2au6OmTzIk+Q="; 
    };
    pnpmDeps = super.pnpm.fetchDeps {
      pname = "youtube-music";
      version = "master";
      src = src;
      fetcherVersion = 1;
      hash = "sha256-MBiYTKef9bCHbLmFUWXKIc9YwnYIngjaXv0rXlp8dQU="; 
    };
  });
}
