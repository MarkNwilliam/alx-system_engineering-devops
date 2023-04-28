#!/bin/bash
# This script takes a URL, sends a request to it, and displays the size of the body of the response in bytes

url=$1
curl -sI "$url" | grep 'Content-Length' | cut -d' ' -f2
