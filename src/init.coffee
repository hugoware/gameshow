
$util = require 'util'
$config = require './config'
$game = require './models/game'
$user = require './models/user'
$io = require 'socket.io'



# utility functions
$util.hash = ( str ) ->
  hash = 0
  return hash if str.length is 0

  for letter, i in str
    chr   = str.charCodeAt i;
    hash  = ((hash << 5) - hash) + chr
    hash |= 0;

  hash





# load each game available game
$game.load type for type in $config.types

# link up socket requests
$io.instance.sockets.on 'connection', ( socket ) ->

  # standard disconnect event
  socket.on 'disconnect', ( data ) ->
    $user.disconnect socket


  # handle linking client ID to sockets
  socket.on 'app:connect', ( data ) ->
    result = $user.connect socket, data.id


  # try and join a game
  socket.on 'game:join', ( data ) ->
    $user.set socket, data
    $game.join socket, data


  # creates a new game
  socket.on 'game:create', ( data ) ->
    $game.create socket, data


  # sets the visible question
  socket.on 'navigate:question', ( data ) ->
    $game.set_question socket, data


  # sets the current section
  socket.on 'navigate:section', ( data ) ->
    $game.set_section socket, data


  # clears the current section
  socket.on 'navigate:clear', () ->
    $game.set_clear socket


  # tries to answer the current question
  socket.on 'game:answer', ( data ) ->
    $game.answer socket, data



  # let the user know a connection
  socket.emit 'app:ready'