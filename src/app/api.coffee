Note = require './models/note'

module.exports =
  newNote: (req, res) ->
    note = new Note
    note.user = req.body.user
    note.title = req.body.title
    note.content = req.body.content
    note.timestamp = Date.now()
    note.save (err) ->
      if err
        res.send err
      res.json {
        msg: 'Done'
        title: note.title
      }
  getNote: (req, res) ->
    Note.findById req.params.note_id, (err, note) ->
      if err
        res.send err
      res.json note
  getAllNotes: (req, res) ->
    Note.find (err, notes) ->
      if err
        res.send err
      res.json notes
  deleteNote: (req, res) ->
    console.log 'Removing ' + Object.keys req.body
    Note.findByIdAndRemove req.body.note_id, (err) ->
      if err
        res.status(400).json 'Error: ' + err
    res.json {msg: 'Done'}