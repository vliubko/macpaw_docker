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

COPY		zip_pass_vliubko.sh /
RUN 		chmod +x /zip_pass_vliubko.sh
RUN 		/zip_pass_vliubko.sh