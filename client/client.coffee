Meteor.startup ->
	@track = -> (false for i in [0...16])
	@Grid = (n)->
		grid = -> (track() for i in [0...n])
		return grid()
	@drawUtils = {
		drawGrid: null
	}

	window.audioContext = new webkitAudioContext()
	window.seq = sequencer(window.audioContext)
	window.BUFFERS = []
	grid = Grid(2)

	Session.setDefault "bpm", 120
	Session.setDefault "beat", 0
	Session.set "grid", grid
	Session.set "fNames", {}
	Session.set "isPlaying", false

