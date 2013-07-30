express = require 'express'
server = express()

fs = require 'fs'

console.log "Searching for data."
data = fs.readdirSync 'server/data'

console.log "\nFound data:"
console.log data

data.forEach (file) ->
  console.log '\nReading ' + file
  fileContents = fs.readFileSync 'server/data/' + file
  fileJSON = JSON.parse fileContents
  console.log '\nFinished reading ' + file

  endpoint = file.replace /\..+$/, ''
  console.log '\nSetting up rest endpoint for ' + endpoint

  server.get '/' + endpoint, (req, res) ->
    res.send { results: fileJSON.initialData }

server.listen 3000
console.log 'Listening on port 3000'
