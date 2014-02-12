Session.setDefault "tracks", [
	{"kick":  [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]},
	{"snare": [0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0]},
	{"hho":   [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]},
	{"hhc":   [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]}
	]


class BufferLoader
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


sequencer = (audioContext)->
	isPlaying = false
	current16thNote = null
	tempo = 120.0
	lookahead = 25.0
	scheduleAheadTime = 0.1
	nextNoteTime = 0.0
	noteResolution = 0
	noteLength = 0.05
	timerID = 0

	playSound = (time, name)->
		buffer = window.BUFFERS[name]
		source = window.audioContext.createBufferSource()
		source.buffer = buffer
		source.connect(audioContext.destination)
		source.start(time)

	playSounds = (beatNumber, time)->
		tracks = Session.get "tracks"
		console.log tracks
		for track in tracks
			for k,v of track
				if v[beatNumber] is 1
					playSound(time, k)

	nextNote = ->
		secondsPerBeat = 60.0 / tempo
		nextNoteTime += 0.25 * secondsPerBeat
		current16thNote++

		if current16thNote == 16
			current16thNote = 0

	scheduleNote = ( beatNumber, time )->
		if ( (noteResolution is 1) && (beatNumber%2))
			return
		if ( (noteResolution is 2) && (beatNumber%4))
			return
		playSounds(beatNumber, time)


	scheduler = ->
		console.log "in scheduler: " , audioContext
		# while there are notes that will need to play before the next interval,
		# schedule them and advance the pointer.
		while (nextNoteTime < audioContext.currentTime + scheduleAheadTime )
			scheduleNote( current16thNote, nextNoteTime )
			nextNote()
		timerID = window.setTimeout( scheduler, lookahead )


	play = ->
		isPlaying = !isPlaying

		if (isPlaying)
			current16thNote = 0
			nextNoteTime = audioContext.currentTime
			scheduler()    # kick off scheduling
			return "stop"
		else
			window.clearTimeout( timerID )
			return "play"
		return

	return play


init = ()->
	window.audioContext = new webkitAudioContext()
	window.seq = sequencer(window.audioContext)
	window.BUFFERS = []


loadSound = (filePath)->
		request = new XMLHttpRequest()
		request.open("GET", filePath, true)
		request.responseType = "arraybuffer"
		request.onload = ->
			window.audioContext.decodeAudioData request.response, (buffer)->
      				window.samples.snare = buffer
		request.send()


drawTrack = (paper, inst)->
	color = (i)->
		if i is 1
			return fill: "#00FFFF"
		else
			return fill: "#000000"

	pttr = Session.get(inst)
	for i in [0..15]
		fill = color(pttr[i])
		circ = paper.circle(10 + 21 * i, 15, 7)
			.attr(fill)
			.data("i", i)
		circ.click ()->
			i = [@data("i")]
			pttr = Session.get(inst)
			c = if pttr[i] is 0 then 1 else 0
			pttr[i] = c
			Session.set inst, pttr
			@attr(color(c))
			console.log Session.get inst



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

	window.addEventListener("load", init )
	###
	#-------------------------------------------
	# Raphael Drawing Stuff
	#-------------------------------------------
	kickPaper = Raphael 'canvas_kick'
	snarePaper = Raphael 'canvas_snare'
	kickPaper.setSize(800,25)
	snarePaper.setSize(800,25)
	drawTrack(kickPaper, "kick")
	drawTrack(snarePaper, "snare")
	###

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
