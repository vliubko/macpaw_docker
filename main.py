def application(env, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    hello = b"<center>Hello from MacPaw<br><br><br><a href=\"http://google.com\"><div>Hello world</div></a></center>"
    return [hello]
