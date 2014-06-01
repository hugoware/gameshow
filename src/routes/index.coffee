$fs = require 'fs'
$path = require 'path'
$config = require '../config'
$game_repository = require '../game_repository'

# handles rendering the default view
module.exports = ( request, response ) ->

  # render the view
  response.render 'index',
    id: request.sessionID
    types: $game_repository.available()
