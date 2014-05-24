$fs = require 'fs'
$path = require 'path'
$config = require '../config'

# handles rendering the default view
module.exports = ( request, response ) ->

  # render the view
  response.render 'index',
    id: request.sessionID
