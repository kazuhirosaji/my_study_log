$ ->
  $('#save').click ->
    mem = $('#calendar').fullCalendar('clientEvents')
    $('#mark_subjects').get(0).value = ""
    $.each(mem, ( index, value ) ->
      $('#mark_subjects').get(0).value +=  value.title + " | " + value.start + " , "
    )

ready = ->
  alert("load")
  $('#calendar').fullCalendar
    defaultView: 'month'
    editable : true

    dayClick : (date, allDay, jsEvent, view) ->
      mode = $('#subject_id').val()
      $('#calendar').fullCalendar('addEventSource', [{
        title: mode,
        start: date,
        allDay: true
      }])

    eventClick: (calEvent, jsEvent, view) ->
      $('#calendar').fullCalendar('removeEvents', calEvent._id)

  # Load Calendar data from Marks and Subjects Model
  events = $("#debug_text").get(0).value.split("\n")
  $.each(events, (id, event) ->
    detail = event.split(",")
    if (detail[1])
      $('#calendar').fullCalendar('addEventSource', [{
        title: detail[0],
        start: detail[1],
        allDay: true
      }])
  )

$(document).ready(ready)
$(document).on('page:load', ready)