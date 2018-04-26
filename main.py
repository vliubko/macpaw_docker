from flask import Flask
from urllib.request import urlopen

app = Flask(__name__)
my_ip = urlopen('http://ip.42.pl/raw').read()

@app.route('/ip', methods=['GET'])
def application(env, start_response):
	start_response('200 OK', [('Content-Type', 'text/html')])
	css = b"<style>@import url('https://fonts.googleapis.com/css?family=Fredoka+One');</style>"
	css = css + b"<style>body{background-color:rgb(26,26,26); color: white; font-family: monospace; font-size: 20px;}"
	button_css = b"#ip{background-color: #2fba6d; color: white; display: block;	font-family: 'Fredoka One', sans-serif;"
	button_css = button_css + b"border-radius: 20px; padding: 10px;	text-decoration: none; width: 190px; text-align: center;"
	string = b"<center><div style='margin-top: 20%'>Your ip is: </div><br>"
	button = b"<div id ='ip'>"

	return [css + button_css + b"</style>" + string + button + my_ip + b"</div></center>"]

if __name__ == "__main__":
   app.run()
