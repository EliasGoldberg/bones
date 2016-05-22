var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('This is Node JS on ' + process.env.PORT + '\n');
}).listen(process.env.PORT,'127.0.0.1');
