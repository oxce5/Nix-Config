{
  user-agent = "Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0";
  check-integrity = true;
  continue = true;
  max-concurrent-downloads = 5;
  max-connection-per-server = 16;
  min-split-size = "10M";
  split = 10;
  enable-color = true;
  console-log-level = "warn";
  summary-interval = 60;
  daemon = false;
  disable-ipv6 = true;
  log-level = "notice";
  input-file = "/aria2/aria2.session";
  save-session = "/aria2/aria2.session";
  save-session-interval = 60;
  dir = "/aria2/downloads";
  file-allocation = "trunc";
  disk-cache = "64M";

  max-tries = 5;
  retry-wait = 30;
  timeout = 60;
  connect-timeout = 60;
  lowest-speed-limit = 0;

  enable-rpc = true;
  rpc-listen-all = true;
  rpc-allow-origin-all = true;
  rpc-listen-port = 6800;

  enable-dht = true;
  bt-enable-lpd = true;
  bt-max-open-files = 100;
  bt-max-peers = 55;
  bt-request-peer-speed-limit = "512K";
  bt-save-metadata = true;
  bt-seed-unverified = true;
  bt-stop-timeout = 600;
  dht-listen-port = "6881-6999";

  auto-file-renaming = false;
}
