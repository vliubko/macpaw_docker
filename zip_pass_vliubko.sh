#!/bin/sh

set -e

# $var_a = most common non-200 response code at /var/log/nginx/old.log
# grep non-200 status, cut status values and count unique, sorting and printing most common value
# $var_a = 401
var_a=$(cat /var/log/nginx/old.log | grep -v "status=200" | awk -F " " {'{print $8}'} | cut -d "=" -f2 | sort | uniq --count | sort -r | head -n1 | awk {'print $2'})

# $var_b = number of requests from 8.8.8.8 at /var/log/nginx/old.log
# grep requests and count them
# $var_b = 790
var_b=$(cat /var/log/nginx/old.log | grep "remote_addr=8.8.8.8" | wc -l)

# $var_c = the two first symbols from ETag header of a file
# curl with verbose mode to find ETag, redirect stderr to stdout, and print substring from line
# $var_b = 51
var_c=$(curl -v --silent hint.macpaw.io 2>&1 | grep "ETag:" | awk '{print substr($0,10,2)}')

# $zip_pass = sum of var_a, var_b, var_c
# zip_pass equals to 1242
zip_pass=$(($var_a + $var_b + $var_c))

# write zip password to file /app/zip_pass.txt
echo $zip_pass > /app/zip_pass.txt

exec "$@"
