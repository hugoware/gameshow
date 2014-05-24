
$ = module.exports
$fs = require 'fs'
$path = require 'path'


# loads an external configuration file
$.load = ( source ) ->

  # read the config
  path = $path.resolve source or '../config.json'
  content = $fs.readFileSync path
  config = JSON.parse content.toString()

  # assign it to this module
  $[ id ] = value for id, value of config