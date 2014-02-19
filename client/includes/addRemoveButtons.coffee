Template.addRemoveButtons.events =
	'click #addTrack': (e, t)->
		console.log t
		e.preventDefault()
		grid = Session.get "grid"
		console.log grid
		newTrack = track()
		grid.push newTrack
		Session.set "grid", grid
		drawUtils.drawGrid()

	'click #removeTrack': (e, t)->
		console.log t
		e.preventDefault()
		_grid = Session.get "grid"
		grid = _grid[0...-1]
		Session.set "grid", grid
		drawUtils.drawGrid()
		newBuffers = window.BUFFERS[0...-1]
		window.BUFFERS = newBuffers
		names = Session.get "fNames"
		names = names[0...-1]
		Session.set "fNames", names

