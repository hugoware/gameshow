
$config = require './config'
require './extend'

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
$app.post '/data', require './routes/data'
$app.post '/status', require './routes/status'
$app.post '/ping', require './routes/ping'


# dev config
if $app.get 'env' is 'development'
  $app.use $express.errorHandler()


# start listening
$server = $app.listen $config.port
$io.instance = $io.listen $server

# initialize
require './init'
