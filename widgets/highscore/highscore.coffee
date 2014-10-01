class Dashing.Highscore extends Dashing.Widget      
#  ready: ->
    # This is fired when the widget is done being rendered
    
  @accessor 'archievedAtMessage', ->
    if @get('archievedAt')
      timestamp = new Date(@get('archievedAt') * 1000)
      year = parseInt(timestamp.getFullYear())
      month = parseInt(timestamp.getMonth())+1
      day = parseInt(timestamp.getDate())
      hours = parseInt(timestamp.getHours())
      minutes = parseInt(timestamp.getMinutes())
      "Erreicht: #{day}.#{month}.#{year} #{hours}:#{minutes}"
    else
      ""

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
