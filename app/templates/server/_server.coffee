express = require 'express'
server = express()

server.get '/hi', (req, res) ->
  body = 'Hello World'

  res.setHeader 'Content-Type'   , 'text/plain'
  res.setHeader 'Content-Length' , body.length

  res.end body

server.listen 3000
console.log 'Listening on port 3000'
