user www-data;
worker_processes  {{ nginx.worker_processes }};

error_log  /var/log/nginx/error.log;
pid        /run/nginx.pid;

events {
  worker_connections  {{ nginx.worker_connections }};
}

http {

  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;


  access_log    /var/log/nginx/access.log;

  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;

  keepalive_requests 100;
  keepalive_timeout  65;


  gzip  on;
  gzip_http_version 1.0;
  gzip_comp_level 2;
  gzip_proxied any;
  gzip_vary off;
  gzip_types text/plain text/css application/x-javascript text/xml application/xml application/rss+xml application/atom+xml text/javascript application/javascript application/json text/mathml;
  gzip_min_length  1000;
  gzip_disable     "MSIE [1-6]\.";


  variables_hash_max_size 1024;
  variables_hash_bucket_size 64;
  server_names_hash_bucket_size 64;
  types_hash_max_size 2048;
  types_hash_bucket_size 64;
  client_body_buffer_size {{ nginx.client_body_buffer_size }};
  client_max_body_size {{ nginx.client_max_body_size }};



  include /etc/nginx/conf.d/*.conf;
  include /etc/nginx/sites-enabled/*;
}
