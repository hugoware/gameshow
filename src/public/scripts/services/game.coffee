
# interacts with the game instance

angular.module 'gameshow'
  .service 'Game', ( $http, Socket ) ->

    # enums
    @.QUESTION = 1
    @.SECTION = 2


    # # game state ( for views, etc )
    # @.state = { }


    # does some cleanup to data to make it
    # easier to use on the client side
    _format = ( data ) ->
      return unless data
      console.log data

      # link each category
      for key, index in data.categories
        category = data[ key ] or { }

        # update data
        category.key = key

        # replace with the category
        data.categories[ index ] = category

      # link category sections
      for category in data.categories
        category.sections = category.sections or [ ]

        # format the section
        for key, index in category.sections

          # get the section
          section = category[ key ] or { }

          # update section data
          section.key = key
          section.category = category.key
          section.value = "$#{ index+1 }00"

          # replace with the new section
          category.sections[ index ] = section


      # share the data
      data


    # tries to load game data
    @.load = ( callback ) ->
      $http.get '/data'

        # errors just fail
        .error => callback?()

        # success loads data for display
        .success ( data ) =>
          @.data = _format data
          callback?( data )



    # gets the default status for a game view
    @.status = ( callback ) ->
      $http.get '/status'

        # errors just fail
        .error => callback?()

        # success loads data for display
        .success ( data ) =>
          callback?( data )


    @ # return the instance
