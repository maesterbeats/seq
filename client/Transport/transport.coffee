Template.transport.helpers
	bpm: ->
		Session.get "bpm"
	beatNum: ->
		b = Session.get "beat"

Template.transport.events =
	'click #incBPM': (e)->
		e.preventDefault()
		bpm = Session.get "bpm"
		bpm += 2
		Session.set "bpm", bpm
	'click #decBPM': (e)->
		e.preventDefault()
		bpm = Session.get "bpm"
		bpm -= 2
		Session.set "bpm", bpm
	'click #startClock': (e)->
		# console.log e
		e.preventDefault()
		window.seq()

