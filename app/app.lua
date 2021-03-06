local server    = require 'lusty-nginx' --load my chosen server module
local configure = require 'lusty-config'--load my chosen configurator
local config    = require 'config'      --load config table

local lusty     = require 'lusty'()     --load and create lusty
configure(lusty, config)                --configure using config table
return server(lusty)                    --add the server wrapper, return
