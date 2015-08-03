<h1>ONGR sandbox dev Docker containers</h1>

This project brings up a development environment for ONGR with the following structure:
1. A vagrant VM with ubuntu base box on your host.
2. A docker daemon inside the vagrant VM with 4 containers running:
  * NGINX
  * PHP5-FPM
  * Elasticsearch
  * MySQL

The whole project with docker images pulled will be using ~3GB of space and 2GB RAM for it is recommended. The project depends on 2 vagrant plugins and they're installed automatically.

### Install instructions

1. Clone this repo and navigate to it's dir. The `src/public` document root dir will be mounted as a volume for the docker php and nginx containers, so changes will persist across your host, VM host and docker containers. It's already populated with ONGR sandbox code, but you can replace it with yours. Take a look at the `parameters.yml` for database and elasticsearch settings though. Run vagrant up to start the box and containers inside it. The first boot will take some time until all docker images are pulled to the VM. 

2. If everything went as planned, you can list the running containers by ssh'ing into the VM with `vagrant ssh` and running `docker-compose ps` inside the rootdir `/var/www/`. You may now access the web container via http://ongr.dev:8080. Elasticsearch can be accessed via http://ongr.dev:9222/_plugin/head/. 

3. There are bash aliases created for container access inside the VM. After `vagrant ssh`, you can access each container with the following commands:
  ```
  ongr_web
  ongr_php
  ongr_es
  ongr_db
  ```
