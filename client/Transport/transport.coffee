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
		e.preventDefault()
		playing = Session.get "isPlaying"
		if playing is off
			Session.set "isPlaying", on
			window.seq()
	'click #stopClock': (e)->
		e.preventDefault()
		playing = Session.get "isPlaying"
		if playing is on
			Session.set "isPlaying", off
			window.seq()

