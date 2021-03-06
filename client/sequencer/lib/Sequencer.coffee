getActive = (grid, col)-> (i for row,i in grid when row[col] is on)

@sequencer = (audioContext)->
	isPlaying = false
	current16thNote = null
	tempo = 120.0
	lookahead = 25.0
	scheduleAheadTime = 0.1
	nextNoteTime = 0.0
	noteResolution = 0
	noteLength = 0.05
	timerID = 0

	playSound = (time, track)->
		buffer = window.BUFFERS[track]
		source = window.audioContext.createBufferSource()
		source.buffer = buffer
		source.connect(audioContext.destination)
		source.start(time)

	playSounds = (beatNumber, time)->
		grid = Session.get "grid"
		Session.set "beat", beatNumber
		a = getActive(grid,beatNumber)
		console.log a
		for track in a
			playSound(time,track)
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
		# console.log "in scheduler: " , audioContext
		# while there are notes that will need to play before the next interval,
		# schedule them and advance the pointer.
		while (nextNoteTime < audioContext.currentTime + scheduleAheadTime )
			scheduleNote( current16thNote, nextNoteTime )
			nextNote()
		timerID = Meteor.setTimeout( scheduler, lookahead )


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
	setBpm = (bpm)->
		tempo = bpm

	return [play, setBpm]
