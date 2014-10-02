class Dashing.Highscore extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue
    
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
      timestamp = new Date(@get('updatedAt') * 1000)
      hours = timestamp.getHours()
      minutes = ("0" + timestamp.getMinutes()).slice(-2)
      "Last updated at #{hours}:#{minutes}"

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
