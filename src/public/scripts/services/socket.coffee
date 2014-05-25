
# interacts with the game instance

angular.module 'gameshow'
  .service 'Socket', ( $http, $location, $rootScope, Config ) ->

    # a list of deferred bindings
    pending = [ ]

    # socket connection
    @.url = "#{ $location.protocol() }://#{ $location.host() }:#{ $location.port() }"

    # connect to the server
    @.socket = io.connect @.url


    # adds a handler for socket events
    @.on = ( event, action ) ->
      handle = ( data ) =>
        console.log 'on', event, data
        angular.safe_apply $rootScope, -> action data

      # perform event as needed
      @.socket.on event, handle


    # waits for a socket response
    @.once = ( event, action ) ->

      # create a simple handler
      handle = ( data ) =>
        console.log 'once', event, data
        angular.safe_apply $rootScope, -> action data
        @.socket.removeListener event, handle

      # perform this only once
      @.socket.on event, handle


    # sends a socket request
    @.emit = ( event, data ) ->
      console.log 'emit', event, data
      @.socket.emit event, data


    @