{
  programs.mangohud = {
    enable = true;
    settings = {
      round_corners = 10;

      position = "top-left";
      toggle_hud = "Shift_R+F12";
      pci_dev = "0:01:00.0";
      table_columns = 3;
      gpu_text = "RTX 3050";
      gpu_stats = true;
      gpu_load_change = true;
      gpu_load_value = [50 90];
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_temp = true;
      gpu_power = true;
      cpu_text = "i5-13450HX";
      cpu_stats = true;

      cpu_load_change = true;
      cpu_load_value = [50 90];
      cpu_mhz = true;
      cpu_temp = true;
      cpu_power = true;
      vram = true;
      ram = true;
      fps = true;
      engine_version = true;
      frame_timing = true;
      fps_limit_method = "late";
      toggle_fps_limit = "none";

      fps_limit = 69;
      fps_color_change = true;
      fps_sampling_period = 2000;
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
