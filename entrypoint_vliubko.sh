#!/bin/sh

set -e

var_a=$(cat /var/log/nginx/old.log | grep -v "status=200" | awk -F " " {'{print $8}'} | cut -d "=" -f2 | sort | uniq --count | sort -r | head -n1 | awk {'print $2'}); echo $var_a;
var_b=$(cat /var/log/nginx/old.log | grep "remote_addr=8.8.8.8" | wc -l); echo $var_b;
var_c=$(curl -v --silent hint.macpaw.io 2>&1 | grep "ETag:" | awk '{print substr($0,10,2)}'); echo $var_c;

exec "$@"