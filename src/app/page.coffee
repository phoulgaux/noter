jade = require 'jade'

module.exports =
  getNoteView: (req, res) ->
    res.send jade.renderFile './dist/app/views/index.jade', {pretty: true}