express = require 'express'
server = express()

fs = require 'fs'

console.log "Searching for data."
data = fs.readdirSync 'server/data'
console.log data

server.get '/hi', (req, res) ->
  body = 'Hello World'

  res.setHeader 'Content-Type'   , 'text/plain'
  res.setHeader 'Content-Length' , body.length

  res.end body

server.listen 3000
console.log 'Listening on port 3000'
