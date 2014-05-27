
# main application controller

angular.module 'gameshow'
  .controller 'AppController', ( $scope, $location, $timeout, App, Config, Socket ) ->

    # share data
    $scope.app = App

    # handles a connected user
    _connected = ( result ) ->
      App.user = result.user
      App.rejoin = result.rejoin

      # go to the login page
      $location.path '/login'


    # connect this client
    Socket.emit 'app:connect', id: Config.CLIENT_ID
    Socket.once 'app:connect:result', _connected

    # watch for disconnects
    Socket.on 'app:disconnect', ( result ) ->
      console.log result
