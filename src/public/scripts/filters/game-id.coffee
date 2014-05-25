
# displays a game ID in an easier to read format

angular.module 'gameshow'
  .filter 'gameId', () ->
    ( value ) ->
      value = ( value or '' ).toString()
      "#{ value.substr(0,3) }-#{ value.substr(3,3) }-#{ value.substr(6,3) }"

