$ = module.exports
$util = require 'util'
$express = require 'express'
$sessions = require '../sessions'
$game = require '../models/game'


# links a user session to a socket
$.connect = ( socket, id ) ->

  # if there is an existing socket, disconnect it
  session = $sessions.get id

  # make sure it's valid
  socket.valid = session?

  # provide a response
  result = success: socket.valid
  result.error = 'invalid_session' unless socket.valid

  # restore user information if possible
  result.user = session.user if session?.user

  # also check if already in a game
  game = $game.get session?.game_id
  if game
    result.rejoin=
      title: game.data.title
      leader: game.leader is session.id

  # without a session, report back an error
  socket.emit 'app:connect:result', result

  # save this data
  if session

    # notify the disconnect
    if session.socket
      session.socket.emit 'app:disconnect', reason: 'too_many_connections'
      session.socket.disconnect()
      $.disconnect session.socket

    # save session data
    session.socket = socket
    socket.session = session
    socket.session_id = session.id



# unlinks a socket from a session
$.disconnect = ( socket ) ->
  unless socket.disconnected
    socket.disconnected = true
    socket.disconnect()



# adds a user to the system
$.set = ( socket, data ) ->
  return unless socket.session?

  # format data
  name = ( data.name or '' ).toString().trim()
  email = ( data.email or '' ).toString().toLowerCase().trim()

  # must have a name
  unless name.length > 0
    return socket.emit 'user:invalid', error: 'name_required'

  # make sure the email isn't used
  if email.length > 0 and _email_in_use email, socket.session.id
    return socket.emit 'user:invalid', error: 'duplicate_email'

  # create the user
  socket.session.user =
    name: data.name
    email: email
    avatar: $util.gravatar email or socket.session.id

  # set the new user info
  socket.emit 'user:set', socket.session.user

  # share the user
  socket.session.user



# disconnects a user
$.remove = ( user ) ->

  # remove the reference ( allow client_id as an option )
  delete $users[ user.id or user ]



# find a logged in user
$.get = ( client_id ) ->
  $users[ client_id ]


# checks if any other session is using this email
_email_in_use = ( email, except_session_id ) ->
  for id, session of $sessions.all()
    if id isnt except_session_id and email is session.user?.email
      return true





