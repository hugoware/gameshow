
# handles the projector view

angular.module 'gameshow'
  .controller 'DisplayController', ( $scope, $location, $timeout, App, Game, Socket ) ->
    $scope.game = Game
    $scope.app = App

    # handle navigation
    # for now, any
    $ document.body
      .keypress ( event ) ->
        return unless $scope.section

        # if spacebar or > then go next
        if event.keyCode in [ 32, 46 ]
          $scope.$apply $scope.next

        # if < then go back
        else if event.keyCode in [ 44 ]
          $scope.$apply $scope.previous

        # if z then leave section
        else if event.keyCode in [ 122 ]
          $scope.$apply $scope.close

    # navigate to the next slide
    $scope.next = ->
      $scope.index = $scope.index + 1
      _update_section()
      angular.clear_selection()


    # navigate to the previous slide
    $scope.previous = ->
      $scope.index = Math.max 0, $scope.index - 1
      _update_section()
      angular.clear_selection()

    # leaves a section
    $scope.close = ->
      Socket.emit 'navigate:clear', cancel: true
      delete $scope.section
      angular.clear_selection()


    # picks a section
    $scope.select = ( section ) ->

      # don't bother if invalid
      return if not section or section.done

      # pick the section
      $scope.section = section
      $scope.index = 0

      # notify the server
      Socket.emit 'navigate:section',
        category: section.category
        section: section.key

      # update the view
      _update_section()


    # handles updating for slide content
    _update_section = ->

      # make sure a section is ready
      return unless $scope.section?

      # reused data
      index=
        slide: $scope.index
        question: $scope.index - $scope.section.slides.length

      # figure out where the view is at
      finished = index.question >= $scope.section.questions.length
      in_slides = index.slide < $scope.section.slides.length
      in_questions = index.question < $scope.section.questions.length

      # notice when about to do questions
      $scope.last_slide = index.slide == $scope.section.slides.length - 1

      # clear existing
      delete $scope.answered
      delete $scope.slide
      delete $scope.question

      # if this finished the $scope.section
      if finished
        $scope.section.done = true
        Socket.emit 'navigate:clear'
        delete $scope.section

      # check if a slide
      else if in_slides
        $scope.slide = $scope.section.slides[ index.slide ]

      # should this be a question?
      else if in_questions
        Socket.emit 'navigate:question', index: index.question
        $scope.question = $scope.section.questions[ index.question ]


    # displays a successful answer
    _update_answer = ( data ) ->
      $scope.answered = data



    # handle navigation requests
    Socket.on 'navigate:next', $scope.next
    Socket.on 'navigate:previous', $scope.previous
    Socket.on 'navigate:select', ( data ) -> $scope.select Game.data[ data.category ]?[ data.section ]

    # handle game state changes
    Socket.on 'game:answered', _update_answer


    # load and make sure data is found
    # only the display section should
    # get game data
    Game.load ( data ) ->
      return $location.path '/' unless data

      # start polling the server
      Game.poll()


