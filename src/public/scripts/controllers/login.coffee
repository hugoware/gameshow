
# handles start and login

angular.module 'gameshow'
  .controller 'LoginController', ( $scope, $location, App, Game, Socket ) ->
    $scope.game = Game

    # set the view
    $scope.view = ( key ) -> $scope.view.at = key


    # tries to join a session
    $scope.join = ->
      Socket.emit 'game:join', name: $scope.name, email: $scope.email, id: $scope.session
      Socket.once 'game:join:result', ( result ) ->

        # they're allowed in
        if result.success
          $location.path '/view'

        # show errors if needed
        else if result.error
          $scope.error = result.error


    # try and make a new game
    $scope.create = ->
      Socket.emit 'game:create', type: $scope.type, password: $scope.password
      Socket.once 'game:create:result', ( result ) ->

        # show the display mode
        if result.success
          $location.path '/display'

        # show errors if needed
        else if result.error
          $scope.error = result.error


    # return to the game
    # ( the view controller should verify )
    $scope.resume = ->
      Socket.emit 'game:rejoin'
      Socket.once 'game:rejoin:result', ( result ) ->

        # handle the new view
        if result.success
          $location.path if $scope.rejoin.leader then '/display' else '/view'

        # show errors if needed
        else if result.error
          $scope.error = result.error


    # quits a game and shows the login
    $scope.leave = ->
      Socket.emit 'game:leave'
      delete  $scope.view


    # watch for user account errors
    Socket.on 'user:invalid', ( result ) -> $scope.error = result.error

    # update user account
    Socket.on 'user:set', ( result ) -> App.user = result


    # restore user info
    if App.user
      $scope.name = App.user.name
      $scope.email = App.user.email


    # check if rejoining is an option
    if App.rejoin
      $scope.rejoin = App.rejoin
      $scope.view 'rejoin'


    # try a default selection
    $scope.type = Game.types?[ 0 ]?.key


