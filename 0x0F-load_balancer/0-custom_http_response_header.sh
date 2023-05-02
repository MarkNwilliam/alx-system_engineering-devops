#!/usr/bin/env bash

# Install Nginx
sudo apt-get update
sudo apt-get install nginx -y

# Stop Nginx service
sudo systemctl stop nginx

# Copy Nginx configuration from web-01 to web-02
sudo scp user@web-01:/etc/nginx/nginx.conf /etc/nginx/nginx.conf

# Start Nginx service
sudo systemctl start nginx

# Add custom header to Nginx configuration
sudo sed -i 's/# server_tokens off;/server_tokens off;\n    add_header X-Served-By $hostname;/' /etc/nginx/nginx.conf

# Restart Nginx service
sudo systemctl restart nginx
