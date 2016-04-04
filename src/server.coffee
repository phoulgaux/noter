##############################################################################
# Requires
##############################################################################

http = require 'http'
express = require 'express'
bodyParser = require 'body-parser'
morgan = require 'morgan'
fs = require 'fs'
mongoose = require 'mongoose'

api = require './app/api'

##############################################################################
# Application
##############################################################################

# configuration

config = JSON.parse fs.readFileSync('./dist/config.json')

# prepare Express app
app = express()
app.use bodyParser.json()

# logger
app.use morgan 'dev'

# db
mongoose.connect(config.mongo.uri)

##############################################################################
# Routing
##############################################################################

# router for notes
noteRouter = express.Router()
noteRouter.get '/', (req, res) ->
  res.format {
    'application/json': ->
      res.json {msg: 'Index hit'}
    'text/html': ->
      res.send '<h1>Html response</h1>'
    'default': ->
      res.status(406).send '<h1>406 Not acceptable</h1>'
  }
noteRouter.get '/note', (req, res) ->
  res.format {
    'application/json': ->
      api.getAllNotes req, res
    'default': ->
      res.status(406).send '<h1>406 Not acceptable</h1>'
  }
noteRouter.get '/note/:note_id', (req, res) ->
  res.format {
    'application/json': ->
      api.getNote req, res
    'default': ->
      res.status(406).send '<h1>406 Not acceptable</h1>'
  }
noteRouter.post '/note', (req, res) ->
  res.format {
    'application/json': ->
      api.newNote req, res
    'default': ->
      res.status(406).send '<h1>406 Not acceptable</h1>'
  }

app.use '/', noteRouter

##############################################################################
# Main loop
##############################################################################

server = http.createServer(app)
server.listen config.port, config.hostname, (err) ->
  console.log "Running on #{config.hostname}:#{config.port}"
  if err
    console.log "Node says: #{err}"
