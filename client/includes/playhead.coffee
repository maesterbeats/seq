Template.playhead.helpers
	'beats': -> (i for i in [0..15])

Template.beat.helpers
	'x': ->
		this * 31 + 15
	'style': ->
		beat = Session.get "beat"
		console.log beat
		x = this
		console.log x.toString() is beat.toString
		if beat.toString() is x.toString()
			return "fill:red"
		else
			return "fill:black"

