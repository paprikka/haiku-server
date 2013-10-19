express     = require 'express'
http        = require 'http'
path        = require 'path'
# MongoStore  = require('connect-mongo') express
# RedisStore  = require('connect-redis') express
# mongoose    = require 'mongoose'
MemoryStore = express.session.MemoryStore


exports.set = (app)->

  app.configure ->

    # You can change the default port using environment variables:
    app.set 'port', process.env.PORT or 8082
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'

    # app.use express.favicon path.join __dirname, 'node_modules', 'connectivity-ui', 'public', 'favicon.ico'
    app.use express.logger('dev')
     
    app.use express.bodyParser uploadDir : './tmp'
    app.use express.methodOverride()
    app.use express.cookieParser()

    # Data in MemoryStore is lost on every server restart. 
    # Use RedisStore to persist sessions between restarts.
    app.use express.session
      secret: 'Hello, my name is Inigo Montoya, you killed my father, prepare to die.'
      store:  new MemoryStore
      maxAge: new Date(Date.now() + 3600000)


    app.use app.router
    # PLAYER_PATH = path.join 'node_modules', 'haiku-player', 'public'
    # REMOTE_PATH = path.join 'node_modules', 'haiku-remote', 'public'

    # app.use '/remote', express.static REMOTE_PATH
    # app.use '/app', express.static PLAYER_PATH


  app.configure 'development', -> 
    app.use express.errorHandler()

  # mongoose.connect 'mongodb://localhost/connectivity-ui'
