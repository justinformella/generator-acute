_ = require 'underscore'
express = require 'express'
server = express()

apiRoot = '/api/'

server.use express.bodyParser()

server.use require('connect-livereload')()

server.use "/", express.static ".tmp/"
server.use "/bower_components", express.static "bower_components/"

fs = require 'fs'

console.log "Searching for data."
data = fs.readdirSync 'server/data'

console.log "\nFound data:"
console.log data

data.forEach (file) ->

  nextID = ->
    latest = _(endpointData).max (datum) -> datum.id
    return 1 + latest.id if _(latest).isObject()
    return 1
  patchObject = (obj) ->
    obj.id ?= nextID()
    obj.modified_at = new Date()
    obj.created_at ?= new Date()
    return obj

  find = (id) ->
    _(endpointData).find((currentData) -> currentData.id == parseInt(id, 10))

  console.log '\nReading ' + file
  fileContents = fs.readFileSync 'server/data/' + file
  fileJSON = JSON.parse fileContents
  console.log '\nFinished reading ' + file

  endpoint = file.replace /\..+$/, ''
  console.log '\nSetting up rest endpoint for ' + endpoint

  endpointData = _(fileJSON.initialData).map patchObject

  server.get apiRoot + endpoint, (req, res) ->
    res.send { results: endpointData }

  server.get apiRoot + endpoint + '/:id', (req, res) ->
    result = find req.params.id
    unless result?
      res.status(404).send { results: null }
    else
      res.send { results: result }

  server.put apiRoot + endpoint, (req, res) ->
    result = find req.body.id
    unless result?
      res.status(404).send { results: null }
    else
      _(result).extend req.body
      res.send { results: result }

  server.delete apiRoot + endpoint + '/:id', (req, res) ->
    result = find req.params.id
    unless result?
      res.status(404).send { results: null }
    else
      endpointData = _(endpointData).without result
      res.send { results: result }

  server.post apiRoot + endpoint, (req, res) ->
    endpointData.push patchObject req.body
    res.status(201).send { results: req.body }

  console.log 'finished...'

server.listen 3000
console.log 'Listening on port 3000'
