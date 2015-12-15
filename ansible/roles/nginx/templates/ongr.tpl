server {
  listen 80;
  server_name {{ nginx.servername }};

  root {{ nginx.docroot }};

  index  app_dev.php app.php;

  access_log            /var/log/nginx/{{ nginx.servername }}.access.log combined;
  error_log             /var/log/nginx/{{ nginx.servername }}.error.log;

  location ~ /\. {
    access_log off;
    log_not_found off;
    deny all;
  }

  location ~ \.php$ {
    root {{ nginx.docroot }};
    index     app_dev.php app.php;
    fastcgi_index {{ nginx.fastcgi_index }};
    fastcgi_param PATH_INFO $fastcgi_path_info;
    fastcgi_param  PATH_TRANSLATED $document_root$fastcgi_path_info;
    fastcgi_param   SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_pass unix:/var/run/php5-fpm.sock;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    include fastcgi_params;
    server_tokens off;
  }
  try_files $uri $uri/ /app_dev.php?$args /app.php?$args;

}
