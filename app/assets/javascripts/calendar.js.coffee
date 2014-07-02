$ ->
  $('#save').click ->
    mem = $('#calendar').fullCalendar('clientEvents')
    $.each(mem, ( index, value ) ->
      alert(value.start)
      alert(value.title)
      $('#debug_text').get(0).value += value.title + "," + value.start + "\n"
    )

  $('#load').click ->
    events = $("#debug_text").get(0).value.split("\n")
    alert(events[0])
    $.each(events, (id, event) ->
      detail = event.split(",")
      alert("detail=" + detail[1])
      if (detail[1])
        alert("add=" + detail[0])
        $('#calendar').fullCalendar('addEventSource', [{
          title: detail[0],
          start: detail[1],
          allDay: true
        }])
    )


$ ->
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

