Meteor.startup () ->
	window.audioContext = new webkitAudioContext()
	window.seq = sequencer(window.audioContext)
	window.BUFFERS = []

	Session.setDefault "tracks", [
		{"kick":  [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]},
		{"snare": [0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0]},
		{"hho":   [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]},
		{"hhc":   [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]}
	]

