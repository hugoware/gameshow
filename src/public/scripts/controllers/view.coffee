
# handles the individual user view

angular.module 'gameshow'
  .controller 'ViewController', ( $scope, $location, App, Game, Socket ) ->
    App.loading = true


    # can the answered badge be shown?
    $scope.can_show_badge = () ->
      $scope.answered? and not $scope.focused


    # display if the game status is valid
    _ready = () ->
      delete App.loading

      # try and stay alive?
      Game.poll()

      # handle answering
      $scope.answer = ( value ) ->
        Socket.emit 'game:answer', id: $scope.question.id, value: value
        Socket.once 'game:answer:result', ( result ) ->
          $scope.result = result

      # watch for server updates
      Socket.on 'navigate:clear', () ->
        delete $scope.location
        delete $scope.question
        delete $scope.answered
        delete $scope.result

      # watch for server updates
      Socket.on 'navigate:section', ( data ) ->
        $scope.location = data

      # watch for server updates
      Socket.on 'navigate:question', ( data ) ->
        $scope.question = data
        delete $scope.result
        delete $scope.answered

      # check for answered questions
      Socket.on 'game:answered', ( data ) ->
        $scope.answered = data


    # make sure they can be here
    Game.status ( result ) ->

      # if there isn't a result, they shouldn't be
      # in this section set
      unless result?
        return $location.path '/'

      # populate any game data
      $scope.location = result.location
      $scope.question = result.question
      $scope.answered = result.answered

      # allow the view to show
      _ready()


