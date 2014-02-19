Meteor.startup ->
	@track = -> (false for i in [0...16])
	@Grid = (n)->
		grid = -> (track() for i in [0...n])
		return grid()
	window.audioContext = new webkitAudioContext()
	window.seq = sequencer(window.audioContext)
	window.BUFFERS = []
	Session.setDefault "bpm", 120
	Session.setDefault "beat", 0
	grid = Grid(1)
	Session.set "grid", grid
	Session.set "fNames", {}
	@drawUtils = {
		drawGrid: null
	}

