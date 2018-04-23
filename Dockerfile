FROM macpaw/internship

RUN		sed -i "s|wsgi-file=/app/wrong.py|wsgi-file=/app/main.py |g" /app/uwsgi.ini
RUN		apt-get update -y
# 		apt-get upgrade -y
RUN		apt-get install -y zip unzip
RUN		apt-get install logrotate -y
RUN		apt-get install -y vim && \
		apt-get install -y socat

EXPOSE 80
