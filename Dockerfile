FROM macpaw/internship

LABEL maintainer="vliubko@student.unit.ua"

# install additional system packages
RUN		apt-get update -y
RUN		apt-get install -y zip unzip logrotate
RUN		apt-get install -y vim

# exposing port 80
EXPOSE 80/tcp

# set correct application at uwsgi.ini file to remove Internal Server Error
RUN		sed -i "s|wsgi-file=/app/wrong.py|wsgi-file=/app/main.py |g" /app/uwsgi.ini

# change domain from localhost to internship.macpaw.io at nginx.conf file
RUN		sed -i "s|server_name localhost;|server_name internship.macpaw.io;|g" /etc/nginx/conf.d/nginx.conf






