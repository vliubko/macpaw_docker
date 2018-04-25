FROM macpaw/internship

LABEL maintainer="vliubko@student.unit.ua"

# install additional system packages
RUN		apt-get update -y
RUN		apt-get install -y zip unzip logrotate
RUN		apt-get install -y vim
RUN		pip install Flask

# exposing port 80
EXPOSE 80/tcp

# Task to change config files. Two methods below

# method #1: using sed replace
# set correct application at uwsgi.ini file to remove Internal Server Error
RUN		sed -i "s|wsgi-file=/app/wrong.py|wsgi-file=/app/main.py |g" /app/uwsgi.ini

# method #2: using Dockerfile COPY
# change domain from localhost to internship.macpaw.io at nginx.conf file
COPY	nginx.conf /etc/nginx/conf.d/

COPY	main.py /app/
COPY	index.html /app

# var="$(cat /var/log/nginx/old.log | grep -v "status=200" | awk -F " " {'{print $8}'} | cut -d "=" -f2 | wc -l)"
# echo $var
# cat /var/log/nginx/old.log | grep -v "status=200" | awk -F " " {'{print $8}'} | cut -d "=" -f2 | wc -l
# 706

# cat /var/log/nginx/old.log | grep "remote_addr=8.8.8.8" | wc -l
# 790

# curl -v --silent hint.macpaw.io 2>&1 | grep "ETag:" | awk '{print substr($0,10,2)}'
# 51

# 706+387 = 1093