#!/usr/bin/env bash

# Install HAproxy
sudo apt-get update
sudo apt-get install haproxy -y

# Configure HAproxy
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
sudo bash -c 'echo "
frontend www
    bind *:80
    mode http
    default_backend servers

backend servers
    mode http
    balance roundrobin
    option httpchk HEAD / HTTP/1.1\r\nHost:localhost
    server web-01 [STUDENT_ID]-web-01:80 check
    server web-02 [STUDENT_ID]-web-02:80 check" >> /etc/haproxy/haproxy.cfg'

# Make HAproxy manageable via init script
sudo sed -i 's/ENABLED=0/ENABLED=1/' /etc/default/haproxy

# Restart HAproxy
sudo systemctl restart haproxy
