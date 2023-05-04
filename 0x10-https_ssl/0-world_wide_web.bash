#!/usr/bin/env bash
# This script displays information about subdomains

get_subdomain_info() {
    domain="$1"
    subdomain="$2"
    record=$(dig "$subdomain.$domain" | awk '/^;; ANSWER SECTION:$/,/^$/ { if ($4 == "A") print $1, $4, $5 }')
    if [[ -n "$record" ]]; then
        echo "The subdomain ${subdomain} is a $(echo "$record" | awk '{ print $2 }') record and points to $(echo "$record" | awk '{ print $3 }')"
    fi
}

domain="$1"
subdomain="$2"

if [[ -z "$subdomain" ]]; then
    for sub in www lb-01 web-01 web-02; do
        get_subdomain_info "$domain" "$sub"
    done
else
    get_subdomain_info "$domain" "$subdomain"
fi
