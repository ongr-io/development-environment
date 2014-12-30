#!/bin/sh
curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo curl -sSL https://get.docker.com/ubuntu/ | sudo sh
sudo apt-get install mc dialog -y
sudo apt-get autoremove -y
echo "THE END"
