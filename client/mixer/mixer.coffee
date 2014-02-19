Template.mixer.helpers
	'tracks': ->
		grid = Session.get "grid"
		if grid?
			arr = ({idx: i}for k,i in grid)
		else
			arr = []


Template.uploader.helpers
	'message': ->
		names = Session.get "fNames"
		console.log names
		mess = names[this.idx]
		if mess?
			mess
		else
			"upload"



Template.uploader.events
	'change .file': (e)->
		target = e.target
		file = e.target.files
		updateSessionFiles(file, this)
		bufferCallback = (bufferList)->
			console.log bufferList
			window.BUFFERS.push bufferList[0]
		bufferLoader = new BufferLoader window.audioContext, file, bufferCallback
		bufferLoader.load()


Template.euclidButton.events
	'click #euclid': (e,t)->
		console.log e
		e.preventDefault()
		pulses = $(e.target.parentElement).find("input").val()
		[eucOn,eucOff] = Euclid pulses,16
		console.log "eucOn",eucOn
		console.log "eucOoff",eucOff
		grid = Session.get "grid"
		idx = t.data['idx']
		track = grid[idx]
		for i in eucOn
			track[i] = true
		for i in eucOff
			track[i] = false
		console.log "track: ", track

		grid[idx] = track

		console.log "grid", grid

		Session.set "grid", grid
		drawUtils.drawGrid()


updateSessionFiles = (file, ctx)->
	file_name = file[0]['name']
	names = Session.get "fNames"
	names[ctx.idx] = file_name
	Session.set "fNames", names
