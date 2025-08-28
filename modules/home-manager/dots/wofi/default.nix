{...}:

{
  home.file = {
    ".config/wofi/style.css" = {
      text = ''
        * {
          font-family: 'CaskaydiaMono Nerd Font', monospace;
          font-size: 18px;
        }

        window {
          margin: 0px;
          padding: 20px;
          background-color: #101010;
          opacity: 0.95;
        }

        #inner-box {
          margin: 0;
          padding: 0;
          border: none;
          background-color: #101010;
        }

        #outer-box {
          margin: 0;
          padding: 20px;
          border: none;
          background-color: #101010;
        }

        #scroll {
          margin: 0;
          padding: 0;
          border: none;
          background-color: #101010;
        }

        #input {
          margin: 0;
          padding: 10px;
          border: none;
          background-color: #101010;
          color: @text;
        }

        #input:focus {
          outline: none;
          box-shadow: none;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: #F0f0f0;
        }

        #entry {
          background-color: #101010;
        }

        #entry:selected {
          outline: none;
          border: none;
        }

        #entry:selected #text {
          color: #707070;
        }

        #entry image {
          -gtk-icon-transform: scale(0.7);
        }
      '';
    };
  };

  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 350;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
  };
}
