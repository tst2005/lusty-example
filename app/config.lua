return {
  subscribers = {
    ['input'] = {
      -- decode json input if it exists in the body data.
      -- you can provide -- options to the handler as a table.
      -- in this case, we are passing in a json encoding/decoding function.
      ['lusty-json.input.json'] = { json = require 'cjson' }
    },

    -- / is routed to /index in nginx
    -- ./handlers/requests/index.lua is loaded when /index is requested
    ['request:index'] = { 'handlers.requests.index' },
    ['request:404'] = { 'handlers.requests.404' },
    ['request:500'] = { 'handlers.requests.500' },

    -- default to 404 if none of the above request routes match
    ['request'] = { 'handlers.requests.404' },

    -- add mustache parsing to the render events
    ['render'] = { 'lusty-mustache.render.mustache' },

    -- capture html requests as mustache handlers, and
    -- capture json requests to output handler data as json
    ['output'] = {
      'lusty-html.output.html',
      ['lusty-json.output.json'] = { json = require 'cjson' }
    },

    -- log events should write to the console
    -- log events should also go up to nginx
    ['log'] = {
      'lusty-log-console.log.console',
      'lusty-nginx.log'
    }
  },

  -- as requests come in, fire these events in order (corresponding to
  -- subscribers above)
  publishers = {
    {'input'},
    {'request'},
    {'render'},
    {'output'}
  },

  -- bind context methods to the context object that is passed around, so you
  -- can use things like context.log and context.store from within your handler
  context = {
    ['lusty-log.context.log'] = { level = 'debug' }
  }
}