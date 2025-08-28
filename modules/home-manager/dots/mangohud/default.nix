{
  programs.mangohud = {
    enable = true;
    settings = {
      background_alpha = 0.1; # last value in the conf
      round_corners = 10;
      background_color = "000000";

      font_size = 20;
      text_color = "C0C0C0";
      position = "top-left";
      toggle_hud = "Shift_R+F12";
      pci_dev = "0:01:00.0";
      table_columns = 3;
      gpu_text = "RTX 3050";
      gpu_stats = true;
      gpu_load_change = true;
      gpu_load_value = [50 90];
      gpu_load_color = ["FFFFFF" "FFAA7F" "CC0000"];
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_temp = true;
      gpu_power = true;
      gpu_color = "2E9762";
      cpu_text = "i5-13450HX";
      cpu_stats = true;

      cpu_load_change = true;
      cpu_load_value = [50 90];
      cpu_load_color = ["FFFFFF" "FFAA7F" "CC0000"];
      cpu_mhz = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_color = "26397D";
      vram = true;
      vram_color = "AD64C1";
      ram = true;
      ram_color = "26397D";
      fps = true;
      engine_version = true;
      engine_color = "C0C0C0";
      frame_timing = true;
      frametime_color = "26397D";
      fps_limit_method = "late";
      toggle_fps_limit = "none";

      fps_limit = 69;
      fps_color_change = true;
      fps_sampling_period = 2000;
      fps_color = ["B22222" "FDFD09" "39F900"];
      fps_value = [30 60];
      # offset = 0; # commented in conf
      winesync = true;

      output_folder = "/home/oxce5";
      log_duration = 30;
      autostart_log = false;
      log_interval = 1000;
      toggle_logging = "Shift_L+F2";

      blacklist = ["pamac-manager" "lact" "ghb" "bitwig-studio" "ptyxis" "yumex"];
    };
  };
}
