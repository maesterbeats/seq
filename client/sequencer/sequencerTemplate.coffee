
uploadHandler = (e, name)->
	file = e.target.files
	bufferCallback = (bufferList)->
		window.BUFFERS[name] = bufferList[0]
	bufferLoader = new BufferLoader window.audioContext, file, bufferCallback
	bufferLoader.load()


Template.sequencer.events =
	'click input.btn': (e)->
		console.log e
		e.preventDefault()
		window.seq()
	'change #kick': (e)->
		uploadHandler(e, "kick")
	'change #snare': (e)->
		uploadHandler(e, "snare")
	'change #hho': (e)->
		uploadHandler(e, "hho")
	'change #hhc': (e)->
		uploadHandler(e, "hhc")




#-------------------------------------------------------------------
# Uncomment for midi functionality
# but be warned, its slower than snot.
###
Template.sequencer.rendered = ->
	onsuccesscallback = ( access )->
		m = access
		inputs = m.inputs()
		console.log "inputs: ", inputs
		outputs = m.outputs()
		console.log "outputs: ", outputs
		window.out = m.outputs()[1]
	onerrorcallback = ( err )->
		console.log("uh-oh! Something went wrong!  Error code: " + err.code )

	navigator.requestMIDIAccess().then onsuccesscallback, onerrorcallback
###
