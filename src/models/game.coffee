$ = module.exports
$fs = require 'fs'
$path = require 'path'
$yaml = require 'yamljs'
$config = require '../config'
$util = require 'util'

# expressions used
SPLIT_SLIDES= /\#\/{3,}/g
REMOVE_WHITESPACE= /^(\n|\s)+|(\n|\s)+$/g


# game instances
$games = { }


# existing types
$.types = { }


# start an entirely new game
$.start = ( type ) =>
  $.load type unless type in $.types

  # TODO: do a real clone
  game =
    # id: _generate_id()
    id: '888666777'
    type: type
    data: $util.clone $.types[ type ]

  # share the ID
  game.data.id = game.id

  # the new game
  game



# starts a new game session
$.create = ( socket, params ) ->
  return unless socket.session?

  # verify the setup info
  unless params.password is $config.password
    return socket.emit 'game:create:result', success: false, error: 'incorrect_password'

  # verify the type
  unless params.type is 'css'
    return socket.emit 'game:create:result', success: false, error: 'invalid_game_type'

  # since this is okay, create the game
  game = $.start params.type

  # set the leader for this game
  game.leader = socket.session.id
  socket.session.game_id = game.id

  # save the game reference
  $games[ game.id ] = game

  # join this game
  socket.join game.id
  socket.join "display:#{ game.id }"

  # this was okay
  socket.emit 'game:create:result', success: true



# gets client status info
$.status = ( game ) ->
  question = _get_question game
  location = _get_location game

  # return the status info
  location: location
  question: question
  answered: question?.answered



# finds a game instance
$.set_clear = ( socket, params ) ->
  game = _get socket, leader: true
  return unless game

  # clear all
  _clear_question game, params
  _clear_section game, params

  # clear out all data
  socket.broadcast.in game.id
    .emit 'navigate:clear'



# sets the active question
$.set_question = ( socket, params ) ->
  game = _get socket, leader: true
  return unless game

  # clear the previous question
  _clear_question game

  # get the question
  if game.section?
    game.question = game.section.questions[ params.index ]

  # notify the new question
  if game.question?

    # let connected users know the new question
    socket.broadcast.in game.id
      .emit 'navigate:question', _get_question game




# sets the active section
$.set_section = ( socket, params ) ->
  game = _get socket, leader: true
  return unless game

  # clear the existing session
  _clear_section game

  # assign the new section
  game.category = game.data[ params.category ]
  game.section = game.category?[ params.section ]

  # notify clients if the section changes
  if game.section and game.category

    # let connected users know the new section
    socket.broadcast.in game.id
      .emit 'navigate:section', _get_location game




# add a user to a game
$.join = ( socket, params ) ->

  # if this wasn't found, show the error
  unless socket.session?.user
    return socket.emit 'game:join:result', error: 'user_not_found'

  # find the game
  params.id = _to_id_alias params.id
  game = $games[ params.id ]

  # if this wasn't found, show the error
  unless game
    return socket.emit 'game:join:result', error: 'session_not_found'

  # since it's valid, enter the game
  socket.session.game_id = params.id

  # listen for this room
  socket.join params.id

  # notify this was successful
  socket.emit 'game:join:result', success: true



# loads all data for a game
$.load = ( key ) =>

  # read the main file
  path = $path.resolve "../data/#{ key }/index.yaml"
  data = $yaml.load path

  # save the ID for the source
  data.key = key

  # read in each category
  for category in data.categories
    _category( category, data )

  # cache this game
  $.types[ key ] = data

  # share the data
  data



# handle answering a question
$.answer = ( socket, data ) ->
  game = _get socket

  # make sure this is a user
  unless socket.session?.user?
    return socket.emit 'game:answer:result', success: false, error: 'invalid_user'

  # make sure there is a game
  unless game
    return socket.emit 'game:answer:result', success: false, error: 'missing_game'

  # make sure it's on the right question
  unless game.question?.id is data.id
    return socket.emit 'game:answer:result', success: false, error: 'invalid_question'

  # if already attempted
  if game.question.attempts[ socket.session.id ]
    return socket.emit 'game:answer:result', success: false, error: 'already_tried'

  # save this attempt
  game.question.attempts[ socket.session.id ] = true

  # make sure this can be tested
  value = data.value
  if value is null or value is undefined
    value = '';

  # test the answer
  correct = value.toString().match game.question.answer

  # return the result
  socket.emit 'game:answer:result', success: correct?

  # if this is correct, notify the display
  if correct? and not game.question.answered?

    # mark as answered
    game.question.answered =
      name: socket.session.user?.name or game.default_name or 'Unknown'
      avatar: socket.session.user?.avatar

    # notify the rest of the players
    socket.broadcast.in game.id
      .emit 'game:answered', game.question.answered




# list of games
# TODO: filter to active later
$.active = () -> $games
$.get = ( id ) -> $games[ id ]


# find the game first
_get = ( socket, options ) ->
  game = $games[ socket.session?.game_id ]

  # if this requires they are a leader
  if options?.leader and game?
    game = null unless game.leader is socket.session?.id

  # give back the game
  game


# clears the current question
_clear_question = ( game, params ) ->
  if game.question
    game.question.done = true unless params?.cancel
    delete game.question


# clears the current section
_clear_section = ( game, params ) ->
  if game.section
    game.section.done = true unless params?.cancel
    delete game.section


# load in category data
_category = ( key, game ) =>
  path = $path.resolve "../data/#{ game.key }/#{ key }/index.yaml"
  category = $yaml.load path

  # shouldn't be null later
  return unless category

  # set the category
  category.key = key
  game[ key ] = category

  # read the slides for each section
  for section in category.sections
    _section section, category[ section ], category, game


# set the
_section = ( key, section, category, game ) =>
  path = $path.resolve "../data/#{ game.key }/#{ category.key }/#{ key }.markdown"
  contents = $fs.readFileSync path

  # extract each page and cleanup
  slides = contents.toString().split SPLIT_SLIDES
  slides[ i ] = slide.replace REMOVE_WHITESPACE, '' for slide, i in slides

  # read the markdown
  section.slides = slides

  # setup each question
  for question in section.questions

    # give each on an ID
    question.id = ( $util.hash "#{question.title}::#{category.title}" ).toString( 32 ) + Math.random()
    question.answer = _assign_matching_expression question
    question.attempts = { }




# create a random game id
_generate_id = () -> _to_id_alias( Math.random() ).substr 0, 9

# gets only digits for an ID
_to_id_alias = ( id ) -> ( id || '' ).toString().replace /[^0-9]/g, ''


# handles setting up a regex to check answers
_assign_matching_expression = ( question ) ->

  # create an expression to test values
  if question.choices
    index = ( question.answer.toLowerCase().charCodeAt 0 ) - 97
    new RegExp "^#{ index }$"

  # otherwise, it's a matching expressions
  else

    # set options ( only check if explictly turned off)
    options = ''
    options += 'i' unless question.ignore_case is false
    options += 'g' unless question.global is false

    # create the expression
    new RegExp question.answer, options



# gets minimal question data
_get_question = ( game ) ->
  if game?.question
    id: game.question.id
    title: game.question.title
    choices: game.question.choices


# gets the current game location
_get_location = ( game ) ->
  if game.category? and game.section?
    category: game.category.title if game.category
    section: game.section.title if game.section
