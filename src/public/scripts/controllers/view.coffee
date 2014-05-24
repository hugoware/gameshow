
# handles the individual user view

angular.module 'gameshow'
  .controller 'ViewController', ( $scope, $location, App, Game, Socket ) ->

    # make sure they can be here
    return $location.path '/' unless App.valid

    # handle answering
    $scope.answer = ( value ) ->
      Socket.send 'game:answer', id: $scope.question.id, value: value
      Socket.once 'game:answer:result', ( result ) ->
        console.log 'result', result


    # watch for server updates
    Socket.on 'navigate:clear', ( data ) ->
      delete $scope.location
      delete $scope.question

    # watch for server updates
    Socket.on 'navigate:section', ( data ) ->
      $scope.location = data

    # watch for server updates
    Socket.on 'navigate:question', ( data ) ->
      $scope.question = data