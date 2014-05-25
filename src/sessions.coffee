$ = module.exports
$express = require 'express'

# holds session data
$sessions = { }

# verify a session is active
$.exists = ( id ) -> $express.setup.session.store.sessions[ id ]


# get all sessions
$.all = () -> $sessions


# gets session data
$.get = ( id ) ->
  exists = $.exists id

  # get data if found
  if exists

    # get or create
    data = $sessions[ id ] or { }

    # save the reference
    $sessions[ id ] = data
    data.id = id

    # share it
    data
