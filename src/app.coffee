# requires
$config = require './config'
$express = require 'express'
$http = require 'http'
$path = require 'path'
$session = require 'express-session'
$cookie_parser = require 'cookie-parser'
$path = require 'path'
$io = require 'socket.io'

# configure the site
$config.load process.argv[2] || '../config.json'

# starting point for the app
$http.root = $path.resolve __dirname

# basic server setup
$setup =
  folder:
    views: $path.join $http.root, 'views'
    public: $path.join $http.root, 'public'

  # user sessions
  session:
    store: new $session.MemoryStore
    key: $config.session_key
    secret: $config.session_secret
    name: 'client_id'
    cookie:
      maxAge: 24 * 60 * 60000

# define the app
$app = $express()
$express.instance = $app
$express.setup = $setup


# connection
$app.set 'port', $config.port

# views
$app.set 'views', $setup.folder.views
$app.set 'view engine', 'jade'

# session
$app.use $cookie_parser()
$app.use $session $setup.session


# resources
$app.use $express.static( $setup.folder.public )

# routes
$app.all '/', require './routes/index'
$app.all '/views?/:id', require './routes/view'
$app.all '/data', require './routes/data'
$app.all '/dump', require './routes/dump'


# dev config
if $app.get 'env' is 'development'
  $app.use $express.errorHandler()


# start listening
$server = $app.listen $config.port
$io.instance = $io.listen $server

# initialize
require './init'

#
# $server.listen $config.port, ->
#   console.log "server ready on #{ $config.port }"

# $app.use $express.cookieParser 'your secret here'
# $app.use $express.session secret: 'mysecretcode'

# $app.use $express.favicon()
# $app.use $express.logger('dev')
# $app.use $express.bodyParser()

# $app.use $express.methodOverride()
# $app.use $app.router