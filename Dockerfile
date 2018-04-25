FROM macpaw/internship

LABEL maintainer="vliubko@student.unit.ua"

# 1) install additional system packages
RUN		apt-get update -y
RUN		apt-get install -y zip unzip
#RUN		apt-get install -y vim

# 2) exposing port 80
EXPOSE 80/tcp


# 3, 4, 5) Task to change config files. Two methods below

# method #1: using sed replace
# set correct application at uwsgi.ini file to remove Internal Server Error
RUN		sed -i "s|wsgi-file=/app/wrong.py|wsgi-file=/app/main.py |g" /app/uwsgi.ini

# method #2: using Dockerfile COPY
# change domain from localhost to internship.macpaw.io at nginx.conf file
COPY	nginx.conf /etc/nginx/conf.d/

# change pyhton script to return HTML code with info about author
COPY	main.py /app/


# 6) finding password for zip file

#RUN		/bin/sh -c export VAR_A=$(cat /var/log/nginx/old.log | grep -v "status=200" | awk -F " " {'{print $8}'} | cut -d "=" -f2 | sort | uniq --count | sort -r | head -n1 | awk {'print $2'}); set; env; export

COPY		entrypoint_vliubko.sh /
RUN 		chmod +x /entrypoint_vliubko.sh

ENTRYPOINT ["/entrypoint_vliubko.sh"]
#CMD ["/bin/sh"]
WORKDIR		/app
CMD			["/usr/bin/supervisord"]

# $var_a = most common non-200 response code at /var/log/nginx/old.log
# grep non-200 status, cut status values and count unique, sorting and printing most common value
# $var_a = 401

# $var_b = number of requests from 8.8.8.8 at /var/log/nginx/old.log
# grep requests and count them
# $var_b = 790
		#var_b=$(cat /var/log/nginx/old.log | grep "remote_addr=8.8.8.8" | wc -l) && \
# $var_c = the two first symbols from ETag header of a file
# curl with verbose mode to find ETag, redirect stderr to stdout, and print substring from line
# $var_b = 51
		#var_c=$(curl -v --silent hint.macpaw.io 2>&1 | grep "ETag:" | awk '{print substr($0,10,2)}') && \
# $zip_pass = sum of var_a, var_b, var_c
# echo $zip_pass to check it equals to 1242
		#zip_pass=$(($var_a + $var_b + $var_c))
