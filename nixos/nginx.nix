{ config, pkgs, lib, ...}:

{
  services.nginx = {
    enable = true;
    user = "http";
    # workerProcesses = "auto";
    # workerCpuAffinity = "auto";
    # workerConnections = 1024;
    # httpConfig = ''
    #   worker_processes auto;
    #   worker_cpu_affinity auto;
    #
    #   events {
    #       worker_connections 1024;
    #   }
    #
    #   http {
    #       charset utf-8;
    #       sendfile on;
    #       tcp_nopush on;
    #       tcp_nodelay on;
    #       server_tokens off;
    #       log_not_found off;
    #       types_hash_max_size 4096;
    #       client_max_body_size 16M;
    #
    #       # MIME
    #       include mime.types;
    #       default_type application/octet-stream;
    #
    #       # logging
    #       access_log /var/log/nginx/access.log;
    #       error_log /var/log/nginx/error.log warn;
    #
    #       # load configs
    #       include /etc/nginx/conf.d/*.conf;
    #       include /etc/nginx/sites-enabled/*;
    #   }
    # '';
    httpConfig = ''
    include /etc/nginx/sites-available/mad-fak.conf;
    '';
  };
  systemd.tmpfiles.rules = [ "d /var/log/nginx 0755 nginx nginx -" ];

  # services.nginx.virtualHosts = {
  #   "mad-fak.local" = {
  #     forceSSL = true;
  #
  #     sslCertificate = "/etc/nginx/ssl/selfsigned.crt";
  #     sslCertificateKey = "/etc/nginx/ssl/selfsigned.key";
  #     sslProtocols = "TLSv1.2 TLSv1.3";
  #     sslCiphers = "HIGH:!aNULL:!MD5";
  #     sslPreferServerCiphers = true;
  #
  #     root = "/var/www/mad-fak/public";
  #     index = "index.html";
  #
  #     locations = {
  #       "/login" = {
  #         rewrite = "^ /html/window.html break";
  #       };
  #       "/" = {
  #         tryFiles = "$uri $uri/ =404";
  #       };
  #       "/api/" = {
  #         rewrite = "^/api(/.*)$ $1 break";
  #         proxyPass = "https://localhost:3301";
  #         proxySetHeaders = {
  #           Host = "$host";
  #           XRealIP = "$remote_addr";
  #           XForwardedFor = "$proxy_add_x_forwarded_for";
  #           XForwardedProto = "$scheme";
  #         };
  #       };
  #     };
  #   };
  # };
}
