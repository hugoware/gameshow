
# converts an index to a letter ( A, B, C, D, etc )

angular.module 'gameshow'
  .filter 'option_letter', () ->
    ( index ) -> String.fromCharCode ( index or 0 ) + 65

