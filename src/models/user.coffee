$ = module.exports
$express = require 'express'
$sessions = require '../sessions'


# links a user session to a socket
$.connect = ( socket, id ) ->

  # if there is an existing socket, disconnect it
  session = $sessions.get id

  # make sure it's valid
  socket.valid = session?

  # provide a response
  result = success: socket.valid
  result.error = 'invalid_session' unless socket.valid

  # without a session, report back an error
  socket.emit 'connect:result', result

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
  if socket
    delete socket.session



# adds a user to the system
$.set = ( socket, name, email ) ->
  return unless socket.session?

  # validate the info first
  errors = [ ]
  # no name

  # if this has errors
  if errors.length > 0
    return socket.emit 'user:invalid', errors: errors

  # create the user
  socket.session.user =
    name: name
    email: _gravatar email

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



# generate the gravatar url
_gravatar = ( email ) ->

  # don't bother without an email
  return unless email

  # TODO: gravatar logic
  email


