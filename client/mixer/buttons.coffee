Template.euclidButton.events
	'click #euclid': (e,t)->
		[idx,grid,track] = _btn.buttonHelper(e,t)
		pulses = $(e.target.parentElement).find("input").val()
		[eucOn,eucOff] = Euclid pulses,16
		track = _btn.clearTrack(track)
		for i in eucOn
			track[i] = true
		_btn.updateGrid(grid,idx,track)

Template.inverseButton.events
	'click #invert': (e,t)->
		[idx,grid] = _btn.buttonHelper(e,t)
		mirror_idx = $(e.target.parentElement).find("input").val() - 1
		mirror_track = grid[mirror_idx]
		inverted = (!i for i in mirror_track)
		_btn.updateGrid(grid,idx,inverted)

Template.rotateButtons.events
	'click #rotateRight': (e,t)->
		[idx,grid, track] = _btn.buttonHelper(e,t)
		rotated = _btn.rotateTo(track, 1)
		_btn.updateGrid(grid,idx,rotated)
	'click #rotateLeft': (e,t)->
		[idx,grid, track] = _btn.buttonHelper(e,t)
		rotated = _btn.rotateTo(track, -1)
		_btn.updateGrid(grid,idx,rotated)


Template.clearTrack.events
	'click #clearTrack': (e,t)->
		[idx,grid, track] = _btn.buttonHelper(e,t)
		clearedTrack = _btn.clearTrack(track)
		_btn.updateGrid(grid,idx,clearedTrack)


Template.deleteTrack.events
	'click #deleteTrack': (e,t)->
		[idx,grid, track] = _btn.buttonHelper(e,t)

		grid = (track for track,i in grid when i isnt idx)
		Session.set "grid", grid
		drawUtils.drawGrid()

		_buffs = window.BUFFERS
		filteredBuffers = (buff for buff,i in _buffs when i isnt idx)
		window.BUFFERS = filteredBuffers

		names = Session.get "fNames"
		names = (name for name, i in names when i isnt idx)
		Session.set "fNames", names

###
-------------------------------- BUTTON HELPER FUNCTIONS --------------------------------
###

_btn =
	'buttonHelper': (e,t)->
		e.preventDefault()
		idx = t.data['idx']
		grid = Session.get "grid"
		track = grid[idx]
		return [idx,grid, track]

	'clearTrack': (track)->
		_track = (false for i in track)

	'updateGrid': (grid,idx,track)->
		grid[idx] = track
		Session.set "grid", grid
		drawUtils.drawGrid()

	'rotateTo': (a,ii)->
		right = (i,a)-> x = a.pop(); a.unshift x
		left = (i,a)-> x = a.shift(); a.push x
		if ii > 0 then right(ii,a) else	left(Math.abs(ii), a)
		return a
