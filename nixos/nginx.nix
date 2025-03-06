{
  services.nginx = {
    enable = true;
    user = "http";
    httpConfig = ''
    include /etc/nginx/sites-available/mad-fak.conf;
    '';
  };
  systemd.tmpfiles.rules = [ "d /var/log/nginx 0755 nginx nginx -" ];
}
