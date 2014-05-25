
$sessions = require '../sessions'
$user = require '../models/user'
$game = require '../models/game'

# gets information for the presentaton mode
module.exports = ( request, response ) ->

  # get the shared session
  session = $sessions.get request.sessionID
  game = $game.get session?.game_id

  # check for a game
  unless game?
    return response.end()

  # send back the game data
  response.json $game.status game



