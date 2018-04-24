def application(env, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    hello = b"<center>Hello from MacPaw<br><br><br><button>Get some info<br> about Vadym Liubko</button></center>"
    return [hello]
