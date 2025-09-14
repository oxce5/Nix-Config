{config, ...}:

{
  home.file = {
    ".config/colors.scss".source = "${config.programs.matugen.theme.files}/.config/ignis/colors.scss";
  };
}

