
$util = require 'util'
$config = require './config'
$game = require './models/game'
$game_repository = require './game_repository'
$user = require './models/user'
$io = require 'socket.io'


# load each game available game
$game_repository.init()


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

  # try and rejoin
  socket.on 'game:rejoin', () ->
    $game.join socket, id: socket.session?.game_id, rejoin: true


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
  socket.on 'navigate:clear', ( data ) ->
    $game.set_clear socket, data


  # tries to answer the current question
  socket.on 'game:answer', ( data ) ->
    $game.answer socket, data


  # quits a game
  socket.on 'game:leave', () ->
    $game.leave socket



  # let the user know a connection
  socket.emit 'app:ready'