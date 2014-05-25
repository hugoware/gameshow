
# handles the individual user view

angular.module 'gameshow'
  .controller 'ViewController', ( $scope, $location, App, Game, Socket ) ->
    App.loading = true

    # display if the game status is valid
    _ready = () ->
      delete App.loading

      # handle answering
      $scope.answer = ( value ) ->
        Socket.emit 'game:answer', id: $scope.question.id, value: value
        Socket.once 'game:answer:result', ( result ) ->
          console.log 'result', result

      # watch for server updates
      Socket.on 'navigate:clear', ( data ) ->
        delete $scope.location
        delete $scope.question
        delete $scope.answered

      # watch for server updates
      Socket.on 'navigate:section', ( data ) ->
        $scope.location = data

      # watch for server updates
      Socket.on 'navigate:question', ( data ) ->
        $scope.question = data
        delete $scope.answered

      # check for answered questions
      Socket.on 'game:answered', ( data ) ->
        $scope.answered = data


    # make sure they can be here
    Game.status ( result ) ->
      _ready()