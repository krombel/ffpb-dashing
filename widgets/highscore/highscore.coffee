class Dashing.Highscore extends Dashing.Widget      
#  ready: ->
    # This is fired when the widget is done being rendered
    
  @accessor 'archievedAt', ->
    if @get('archievedAt')
      timestamp = new Date(@get('archievedAt') * 1000)
      year = parseInt(timestamp.getYears())
      month = parseInt(timestamp.getMonths())
      day = parseInt(timestamp.getDays())
      hours = parseInt(timestamp.getHours())
      minutes = parseInt(timestamp.getMinutes().slice(-2))
      "Erreicht: \#{hours}:\#{minutes}"
    else
      ""

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
