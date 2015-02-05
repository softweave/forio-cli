#!/usr/bin/env coffee

path = require "path"

default_config_file = path.normalize "#{__dirname}/../../config.json"
default_config = require default_config_file
default_platform = default_config?.default or "epicenter"

exports.help = "Watch dir for changes and upload to a simulation"

exports.options =
    mapping:
        abbr: "m"
        position: 1
        required: true
        help: "<local_dir>:<account>/<project>"
    platform:
        abbr: "p"
        default: default_platform
        choices: ["epicenter", "simulate"]
        help: "Platform (epicenter or simulate)"
    config_file:
        abbr: "c"
        default: default_config_file
        help: "Path to config file"
    domain:
        abbr: "d"
        default: if default_platform is "simulate" then "forio.com" else "api.forio.com"
        help: "Domain Simulate or Epicenter is hosted on"
    ignore:
        abbr: "i"
        help: "Regex with pattern of files to ignore for sync"

exports.run = (options) ->
    {platform} = options
    config = (require options.config_file)[platform]
    options.user_name = config.user_name
    options.password = config.password

    (require "util/#{platform}/sync").run options
