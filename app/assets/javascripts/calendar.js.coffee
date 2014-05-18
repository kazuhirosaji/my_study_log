$ ->
  $('#calendar').fullCalendar
    defaultView: 'month'
    editable : true

    dayClick : (date, allDay, jsEvent, view) ->
      mode = "saji"
      $('#calendar').fullCalendar('addEventSource', [{
        title: mode,
        start: date,
        allDay: true
      }])

      $(this).css('background-color', 'red');



