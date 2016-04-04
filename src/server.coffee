##############################################################################
# Requires
##############################################################################

http = require 'http'
express = require 'express'
bodyParser = require 'body-parser'
morgan = require 'morgan'

##############################################################################
# Application
##############################################################################

# configuration

config =
  hostname: 'localhost'
  port: 3000

# prepare Express app
app = express()
app.use bodyParser.json()

# logger
app.use morgan 'dev'

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

app.use '/', noteRouter

##############################################################################
# Main loop
##############################################################################

server = http.createServer(app)
server.listen config.port, config.hostname, (err) ->
  console.log "Running on #{config.hostname}:#{config.port}"
  console.log "Node says: #{err}"
