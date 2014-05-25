
# displays a game ID in an easier to read format

angular.module 'gameshow'
  .filter 'game_id', () ->
    ( value ) ->
      value = ( value or '' ).toString()
      if value.length >= 9
        "#{ value.substr(0,3) }-#{ value.substr(3,3) }-#{ value.substr(6,3) }"

