Template.mixer.helpers
	'tracks': ->
		grid = Session.get "grid"
		if grid? then ({idx: i}for k,i in grid) else []

Template.uploader.helpers
	'message': ->
		names = Session.get "fNames"
		mess = names[this.idx]
		if mess? then mess else "upload"


Template.uploader.rendered = ->
	input = this.find('input').click()

Template.uploader.events
	'change .file': (e,i)->
		target = e.target
		idx = i.data.idx
		file = e.target.files
		updateSessionFiles(file, this)
		bufferCallback = (bufferList)->
			window.BUFFERS[idx] = bufferList[0]
		bufferLoader = new BufferLoader window.audioContext, file, bufferCallback
		bufferLoader.load()

updateSessionFiles = (file, ctx)->
	file_name = file[0]['name']
	names = Session.get "fNames"
	names[ctx.idx] = file_name
	Session.set "fNames", names
