#!/bin/bash

cd /home/ubuntu

set -x

# Update package lists
sudo apt-get update

# install NodeSource repo
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# install Node.js
sudo apt-get install -y nodejs

# Firewall settings
echo "y" | sudo ufw enable
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
# port redirection from 80 to 3000
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000 

# Optionally: install iptables-persistent to make iptables rules persistent across reboots
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent 
sudo netfilter-persistent save

# clone LoadMaster
git clone https://github.com/adventuresoul/Sample_web_services.git

cd Sample_web_services
cd node_web_service

# Install dependencies
npm install 

# Run application
# node index.js

# copy service to /etc/systemd/service
sudo cp node_app.service /etc/systemd/system

# reload the system and start and enable the service
sudo systemctl daemon-reload
sudo systemctl start node_app
sudo systemctl enable node_app
sudo systemctl status node_app


