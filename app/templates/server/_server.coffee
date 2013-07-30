express = require 'express'
server = express()

server.use express.bodyParser()

fs = require 'fs'

console.log "Searching for data."
data = fs.readdirSync 'server/data'

console.log "\nFound data:"
console.log data

data.forEach (file) ->

  endpointData = []
  nextID = ->
    id = 1
    endpointData.forEach (currentData) ->
      id = currentData.id + 1 if currentData.id >= id
    return id
  patchObject = (obj) ->
    obj.id ?= nextID()
    obj.updated_at = new Date()
    obj.created_at ?= new Date()
    return obj

  find = (id) ->
    result = null
    endpointData.forEach (currentData) ->
      result = currentData if currentData.id == id
    return result

  console.log '\nReading ' + file
  fileContents = fs.readFileSync 'server/data/' + file
  fileJSON = JSON.parse fileContents
  console.log '\nFinished reading ' + file

  endpoint = file.replace /\..+$/, ''
  console.log '\nSetting up rest endpoint for ' + endpoint

  fileJSON.initialData.forEach (json) ->
    endpointData.push patchObject json

  server.get '/' + endpoint, (req, res) ->
    res.send { results: endpointData }

  server.get '/' + endpoint + '/:id', (req, res) ->
    result = find parseInt(req.params.id, 10)
    if result is null
      res.status(404).send { results: null }
    else
      res.send { results: result }

  server.post '/' + endpoint, (req, res) ->
    endpointData.push patchObject req.body
    res.status(201).send { results: req.body }

  console.log 'finished...'

server.listen 3000
console.log 'Listening on port 3000'
