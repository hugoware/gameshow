
# just a ping to let users know they're connected
module.exports = ( request, response ) ->
  at = new Date
  time = at.getTime()

  # send back the game data
  response.json time



