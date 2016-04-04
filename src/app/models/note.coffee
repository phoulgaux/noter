mongoose = require 'mongoose'

noteSchemaRaw =
  user: Number
  title: String
  content: String
  timestamp: String

NoteSchema = new mongoose.Schema noteSchemaRaw

module.exports = mongoose.model 'Note', NoteSchema