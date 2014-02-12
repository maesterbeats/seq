class @BufferLoader
	constructor: (context, files, callback)->
		@context = context
		@fileList = files
		@onload = callback
		@bufferList = new Array()
	loadBuffer: (files)->
		file = files[0]
		reader = new FileReader()
		loader = this
		reader.onload = ->
			loadCallback = (buffer)->
				loader.bufferList.push buffer
				loader.onload(loader.bufferList)
			loadError = (err)->
				console.log "error: failed to load sound file", err
			arrBuff = reader.result
			loader.context.decodeAudioData arrBuff, loadCallback, loadError
		reader.readAsArrayBuffer(file)
	load: ->
		@loadBuffer(@fileList)
