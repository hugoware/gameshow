
# finds the correct error message for a code

angular.module 'gameshow'
  .filter 'error_message', () ->
    errors=
      session_not_found: 'No session was found with that ID'
      user_not_found: 'Unable to find user - please refresh page'
      unknown: 'An unexpected error occurred'

    ( key ) -> errors[ key ] or key

