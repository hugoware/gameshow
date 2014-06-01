$ = module.exports
$util = require 'util'
$config = require '../config'
$fs = require 'fs'
$path = require 'path'
$yaml = require 'yamljs'

# expressions used
SPLIT_SLIDES= /\#\/{3,}/g
REMOVE_WHITESPACE= /^(\n|\s)+|(\n|\s)+$/g


# existing types
$.types = { }


# load in all game types
$.init = () ->
  $.load type for type in $config.types


# make sure this type exists
$.exists = ( type ) ->
  type in $config.types


# returns a list of allowed game types
$.available = () ->
  { key: key, title: type.title } for key, type of $.types


# reads in all content for a game
$.load = ( key ) =>
  data = $.types[ key ]

  # check if this needs to be loaded
  if not data?

    # read the main file
    path = $path.resolve "../data/#{ key }/index.yaml"
    data = $yaml.load path

    # save the ID for the source
    data.key = key

    # read in each category
    for category in data.categories
      _read_category( category, data )

    # cache this game
    $.types[ key ] = data

  # clone the instance
  $util.clone data



# load each category in a game
_read_category = ( key, game ) =>
  path = $path.resolve "../data/#{ game.key }/#{ key }/index.yaml"
  category = $yaml.load path

  # shouldn't be null later
  return unless category

  # set the category
  category.key = key
  game[ key ] = category

  # read the slides for each section
  for section in category.sections
    _read_section section, category[ section ], category, game



# update each section in a game
_read_section = ( key, section, category, game ) =>
  path = $path.resolve "../data/#{ game.key }/#{ category.key }/#{ key }.markdown"
  contents = $fs.readFileSync path

  # extract each page and cleanup
  slides = contents.toString().split SPLIT_SLIDES
  slides[ i ] = slide.replace REMOVE_WHITESPACE, '' for slide, i in slides

  # just help
  slides = [ 'empty' ] if slides.length is 0

  # read the markdown
  section.slides = slides

  # setup each question
  for question in section.questions

    # give each on an ID
    question.id = ( $util.hash "#{question.title}::#{category.title}" ).toString( 32 ) + Math.random()
    question.answer = _assign_matching_expression question
    question.attempts = { }



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





