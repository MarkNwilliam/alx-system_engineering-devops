#!/bin/bash
set -e

# Ignore SC2154 for shellcheck
# shellcheck disable=SC2154

# Update the system
sudo apt-get update -y

# Install Nginx
sudo apt-get install -y nginx

# Get the hostname
hostname=$(hostname)

# Configure Nginx to add a custom header
echo "Adding custom header in Nginx configuration..."
sudo echo "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    location / {
        add_header X-Served-By $hostname;
    }
}" | sudo tee /etc/nginx/sites-available/default

# Restart Nginx to apply the changes
echo "Restarting Nginx..."
sudo systemctl restart nginx

echo "Nginx configured successfully with custom header."
