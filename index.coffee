
express   = require 'express'
http      = require 'http'
path      = require 'path'
config    = require './config'
ioLib     = require 'socket.io'





app = express()


# Apply config:
# ---------------------------------
config.set app

# Init controllers:
# ---------------------------------
# Remember to preserve the current order when adding new controllers, that is:
# - mocks need to be loaded first 
# - users and user-roles need to be loaded before controllers using authentication
(require("./controllers/#{name}")(app) for name in [
  "test"
])

# Create a server instance and hook it to the app
server = http.createServer(app)
  .listen app.get('port'), ->
    console.log '(COFFEE) Express server listening on port '  + app.get 'port'
    console.log '--------------------------------------------------------------'
    console.log '(COFFEE) Express server current environment:  ', app.settings.env

app.io = ioLib.listen server



app.io.configure -> 
  app.io.set "transports", ["xhr-polling"]
  app.io.set "polling duration", 10

# socket = new io.Socket();

app.io.sockets.on 'connection', (socket)->
  socket.on 'ping', ->
    socket.emit 'pong', {data: Math.random() }

  socket.on 'remote', (data)->
    socket.broadcast.emit 'remote', data
    console.log """
      ---------
      #{JSON.stringify(data)}
      ---------
      """
