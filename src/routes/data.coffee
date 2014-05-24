
$sessions = require '../sessions'
$user = require '../models/user'
$game = require '../models/game'

# gets information for the presentaton mode
module.exports = ( request, response ) ->

  # get the shared session
  session = $sessions.get request.sessionID
  game = $game.get session?.game_id

  # make sure this person can make changes
  in_game = game?
  leader_of_game = game?.leader is session?.id

  # make sure this user can see if
  unless in_game and leader_of_game
    return response.end()

  # send back the game data
  response.json game.data



