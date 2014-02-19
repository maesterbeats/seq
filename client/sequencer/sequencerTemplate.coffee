Template.grid.rendered = ->
	svgElement = document.getElementById("svg")
	console.log drawUtils
	drawGrid = makeGrid(svgElement)
	drawUtils['drawGrid'] = drawGrid
	drawUtils.drawGrid()

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
