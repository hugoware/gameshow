$util = require 'util'
$game = require '../models/game'

# handles rendering other views
module.exports = ( request, response ) ->
  response.end $util.inspect
    games: $game.active()


