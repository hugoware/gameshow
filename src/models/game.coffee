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
    id: '888666777' # _generate_id()
    type: type
    data: JSON.parse JSON.stringify $.types[ type ]

    # general game state
    state: { }

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

  # this was okay
  socket.emit 'game:create:result', success: true



# finds a game instance
$.set_clear = ( socket ) ->
  game = _get socket, leader: true
  return unless game

  # clear all
  _clear_question game
  _clear_section game

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

    # save an ID to validate the question later
    game.question.id = 100000 + ( Math.random() * 899999 )

    # let connected users know the new question
    socket.broadcast.in game.id
      .emit 'navigate:question',
        id: game.question.id
        title: game.question.title
        choices: game.question.choices



# sets the active section
$.set_section = ( socket, params ) ->
  game = _get socket, leader: true
  return unless game

  # clear the existing session
  _clear_section game

  # assign the new section
  category = game.data[ params.category ]
  section = category?[ params.section ]

  # replace the current
  game.section = section

  # notify clients if the section changes
  if game.section

    # let connected users know the new section
    socket.broadcast.in game.id
      .emit 'navigate:section',
        category: category.title
        section: section.title




# add a user to a game
$.join = ( socket, params ) ->
  params.id = _to_id_alias params.id

  # find the game first
  game = $games[ params.id ]

  # if this wasn't found, show the error
  unless socket.session?.user
    return socket.emit 'game:join:result', error: 'user_not_found'

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
_clear_question = ( game ) ->
  if game.question
    game.question.done = true
    delete game.question


# clears the current section
_clear_section = ( game ) ->
  if game.section
    game.section.done = true
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

  # generate IDs for each question
  for question in section.questions
    question.id = $util.hash "#{question.title}::#{category.title}"

  # read the markdown
  section.slides = slides



# create a random game id
_generate_id = () ->
  unless _generate_id.part? then _generate_id.part = ->
    part = ( 0|Math.random() * 999 ).toString()
    ( '000'.substr part.length ) + part

  "#{_generate_id.part()}#{_generate_id.part()}#{_generate_id.part()}"


# gets only digits for an ID
_to_id_alias = ( id ) -> ( id || '' ).replace /[^0-9]/g, ''
