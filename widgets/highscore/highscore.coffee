class Dashing.Highscore extends Dashing.Widget
	@accessor 'current', Dashing.AnimatedValue
  
	@accessor 'archievedAt', ->
		if archievedAt = @get('archievedAt')
			timestamp = new Date(archievedAt * 1000)
		#	year = timestamp.getYears()
		#	month = timestamp.getMonths()
		#	day = timestamp.getDays()
			hours = timestamp.getHours()
			minutes = ("0" + timestamp.getMinutes()).slice(-2)
		"Erreicht: \#{hours}:\#{minutes}"
      
  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.

    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
      
#          class Dashing.Highscore extends Dashing.Widget
