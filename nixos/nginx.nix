{ config, pkgs, ... }:

{
  # Enable Nginx
  services.nginx = {
    enable = true;

  #   # Global Nginx configuration
  #   config = ''
  #     user http;
  #     worker_processes auto;
  #     worker_cpu_affinity auto;
  #
  #     events {
  #       worker_connections 1024;
  #     }
  #
  #     http {
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
  #       include ${pkgs.nginx}/conf/mime.types;
  #       default_type application/octet-stream;
  #
  #       # logging
  #       access_log /var/log/nginx/access.log;
  #       error_log /var/log/nginx/error.log warn;
  #
  #       # load configs
  #       include /etc/nginx/conf.d/*.conf;
  #       include /etc/nginx/sites-enabled/*;
  #     }
  #   '';
  #
  #   # Virtual host configuration for mad-fak.local
  #   virtualHosts."mad-fak.local" = {
  #     # HTTP server block to redirect to HTTPS
  #     serverAliases = [ "mad-fak.local" ];
  #     listen = [
  #       {
  #         addr = "0.0.0.0";
  #         port = 80;
  #       }
  #     ];
  #     locations."/" = {
  #       return = "301 https://$host$request_uri";
  #     };
  #
  #     # HTTPS server block
  #     forceSSL = true;
  #     sslCertificate = "/etc/nginx/ssl/selfsigned.crt";
  #     sslCertificateKey = "/etc/nginx/ssl/selfsigned.key";
  #
  #     # SSL configuration
  #     sslProtocols = "TLSv1.2 TLSv1.3";
  #     sslCiphers = "HIGH:!aNULL:!MD5";
  #     sslPreferServerCiphers = true;
  #
  #     # Serve static files
  #     root = "/var/www/mad-fak/public";
  #     locations."/" = {
  #       index = "index.html";
  #       tryFiles = "$uri $uri/ =404";
  #     };
  #
  #     # Custom location for /login
  #     locations."/login" = {
  #       rewrite = "^ /html/window.html break";
  #     };
  #
  #     # Proxy API requests to backend
  #     locations."/api/" = {
  #       rewrite = "^/api(/.*)$ $1 break";
  #       proxyPass = "https://localhost:3301";
  #       proxySetHeader = {
  #         Host = "$host";
  #         X-Real-IP = "$remote_addr";
  #         X-Forwarded-For = "$proxy_add_x_forwarded_for";
  #         X-Forwarded-Proto = "$scheme";
  #       };
  #     };
  #   };
  # };
  #
  # # Ensure the SSL certificate and key files exist
  # environment.etc."nginx/ssl/selfsigned.crt".source = "/etc/nginx/ssl/selfsigned.crt";
  # environment.etc."nginx/ssl/selfsigned.key".source = "/etc/nginx/ssl/selfsigned.key";
  #
  # # Ensure the directory for static files exists
  # systemd.tmpfiles.rules = [
  #   "d /var/www/mad-fak/public 0755 http http - -"
  # ];
  };
}
