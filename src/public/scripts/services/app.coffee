
# handles keeping track of the state of the game

angular.module 'gameshow'
  .factory 'App', ( $http ) ->

    @.state = -> console.log 'ready'



    @