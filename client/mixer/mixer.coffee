Template.mixer.helpers
	'tracks': ->
		Session.get "grid"

Template.uploader.events
	'change .file': (e)->
		file = e.target.files
		console.log file
		bufferCallback = (bufferList)->
			console.log bufferList
			window.BUFFERS.push bufferList[0]
		bufferLoader = new BufferLoader window.audioContext, file, bufferCallback
		bufferLoader.load()

Template.euclidButton.events
	'click #euclid': (e)->
		e.preventDefault()
		pulses = $(e.target.parentElement).find("input").val()
		[eucOn,eucOff] = Euclid pulses,16
		for i in eucOn
			id = Cells.find(cell:i).fetch()[0]._id
			Cells.update id, $set: val: 1
		for i in eucOff
			id = Cells.find(cell:i).fetch()[0]._id
			Cells.update id, $set: val: 0



