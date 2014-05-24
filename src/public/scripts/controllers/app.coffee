
# main application controller

angular.module 'gameshow'
  .controller 'AppController', ( $scope, App, Game, Config, Socket ) ->

    # share data
    $scope.game = Game
    $scope.app = App
    $scope.socket = Socket


    # handles a connected user
    _connected = ( result ) ->
      console.log result


    # connect this client
    Socket.emit 'app:connect', id: Config.CLIENT_ID
    Socket.once 'app:connect:result', _connected

    # watch for disconnects
    Socket.on 'app:disconnect', ( result ) ->
      console.log result
