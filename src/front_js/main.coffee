{render, text, a, div, h4, p, span} = teacup

renderNote = (note) ->
  timestamp = new Date parseInt note.timestamp
  day = timestamp.getDate().toString()
  month_int = timestamp.getMonth()+1
  if month_int < 10
    month = '0' + month_int.toString()
  else
    month = month_int.toString()
  year = timestamp.getFullYear().toString()

  return render ->
    div {id: 'note_' + note._id, class: 'panel'}, ->
      div '.panel-heading', ->
        div '.row', ->
          div '.col-xs-10', ->
            h4 note.title
          div '.col-xs-2.text-right', ->
            a {href: '#', id: 'delete_note_' + note._id, onclick: 'deleteNote(\'' + note._id + '\');'}, ->
              p 'delete'
      div '.panel-body', ->
        p note.content
      div '.panel-footer.text-right', ->
        p "#{day}.#{month}.#{year}"

closeAddNoteWindow = ->
  $('#add-note').hide()

showAddNoteWindow = ->
  $('#add-note').show()

window.onload = ->
  $('#add-note').hide()
  refresh()

refresh = ->
  console.log 'Refreshing'
  $.getJSON '/note', (data) ->
    noteList = $('#noteList')
    noteList.html render ->
      h4 '#retrieving.text-center', ->
        text 'Retrieving notes…'
    for note in data
      noteList.append renderNote note
    $('#retrieving').remove()

deleteNote = (id) ->
  $.ajax {
    url: '/note'
    type: 'DELETE'
#    contentType: 'application/json; charset=utf-8'
#    dataType: 'json'
    data: {
      note_id: id
    }
    success: ->
#      $('#note_' + id).remove()
      refresh()
  }

addNote = ->
  mtitle = $('#text-title').val()
  mcontent = $('#text-content').val()
  $.post '/note', {user: 0, title: mtitle, content: mcontent}, window.onload, 'json'

