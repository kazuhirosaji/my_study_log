$ ->
  $('#save').click ->
    mem = $('#calendar').fullCalendar('clientEvents')
    $.each(mem, ( index, value ) ->
      alert(value.start)
      alert(value.title)
      $('#debug_text').get(0).value = value.title + ":" + value.start 
    )


$ ->
  $('#calendar').fullCalendar
    defaultView: 'month'
    editable : true
    disableDragging: true

    dayClick : (date, allDay, jsEvent, view) ->
      mode = $('#subject_id').val()
      $('#calendar').fullCalendar('addEventSource', [{
        title: mode,
        start: date,
        allDay: true
      }])

    eventClick: (calEvent, jsEvent, view) ->
      $('#calendar').fullCalendar('removeEvents', calEvent._id)

