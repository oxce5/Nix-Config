{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ll = "ls -l";
      gs = "git status";
      cd = "z";
      lg = "lazygit";
      df = "duf";
    };
    plugins = [
      {
        name = "replay.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "replay.fish";
          rev = "d2ecacd3fe7126e822ce8918389f3ad93b14c86c";
          hash = "sha256-TzQ97h9tBRUg+A7DSKeTBWLQuThicbu19DHMwkmUXdg=";
        };
      }
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "0bfe402753681f705a482694fcaf20c2bfc6deb7";
          hash = "sha256-WA6DBrPBuXRIloO05UBunTJ9N01d6tO1K1uqojjO0mo=";
        };
      }
      {
        name = "pisces";
        src = pkgs.fetchFromGitHub {
          owner = "laughedelic";
          repo = "pisces";
          rev = "e45e0869855d089ba1e628b6248434b2dfa709c4";
          hash = "sha256-Oou2IeNNAqR00ZT3bss/DbhrJjGeMsn9dBBYhgdafBw=";
        };
      }
    ];
  };
}

