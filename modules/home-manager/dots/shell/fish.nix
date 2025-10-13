{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.dots.shells.enableFish {
    programs.fish = {
      enable = true;
      shellAliases = {
        aj = "alejandra ~/nix-setup";
      };
      shellAbbrs = {
        ll = "ls -l";
        gs = "git status";
        cd = "z";
        df = "duf";
        ga = "git add";
        lg = "lazygit";
        ld = "lazydocker";
        nos = "aj && nh os switch";
        nosu = "aj && nh os switch --update";
        nost = "aj && nh os test";
      };
      interactiveShellInit = ''
        bind up _atuin_bind_up

        set -gx EDITOR "nvim"

        if status is-interactive
            if type -q zellij
                # Update the zellij tab name with the current process name or pwd.
                function zellij_tab_name_update_pre --on-event fish_preexec
                    if set -q ZELLIJ
                        set -l cmd_line (string split " " -- $argv)
                        set -l process_name $cmd_line[1]
                        if test -n "$process_name" -a "$process_name" != "z"
                            command nohup zellij action rename-tab $process_name >/dev/null 2>&1
                        end
                    end
                end

                function zellij_tab_name_update_post --on-event fish_postexec
                    if set -q ZELLIJ
                        set -l cmd_line (string split " " -- $argv)
                        set -l process_name $cmd_line[1]
                        if test "$process_name" = "z"
                            command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
                        end
                    end
                end
            end
        end
      '';
      functions = {
        # This fixes the mktemp: Invalid Arg error
        yy = lib.mkForce {
          body = ''
            set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
              command yazi $argv --cwd-file="$tmp"
              if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                  builtin cd -- "$cwd"
              end
              rm -f -- "$tmp"
          '';
        };
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
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
            hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
          };
        }
      ];
    };
  };
}
