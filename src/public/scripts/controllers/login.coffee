
# handles start and login

angular.module 'gameshow'
  .controller 'LoginController', ( $scope, $location, App, Game ) ->

    $scope.password = 'raiden';
    $scope.type = 'css';
    $scope.name = 'fred';
    $scope.email = 'hugo@hugoware.net';
    $scope.session = '888-666-777';

    # set the view
    $scope.view = ( key ) -> $scope.view.at = key


    # tries to join a session
    $scope.join = ->
      Game.join $scope.name, $scope.email, $scope.session, ( result ) ->

        # they're allowed in
        if result.success
          App.valid = true
          $location.path '/view'

        # show errors
        # else


    # try and make a new game
    $scope.create = ->
      Game.create $scope.password, $scope.type, ( result ) ->

        # show the display mode
        if result.success
          $location.path '/display'

        # show errors
        # else


