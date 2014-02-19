Template.grid.rendered = ->
	svgElement = document.getElementById("svg")
	this.drawGrid = makeGrid(svgElement)
	this.drawGrid()

Template.grid.events =
	'click #addTrack': (e, t)->
		console.log t
		e.preventDefault()
		grid = Session.get "grid"
		console.log grid
		newTrack = track()
		grid.push newTrack
		Session.set "grid", grid
		t.drawGrid()
	'click #removeTrack': (e, t)->
		console.log t
		e.preventDefault()
		_grid = Session.get "grid"
		console.log _grid
		grid = _grid[0...-1]
		console.log grid
		Session.set "grid", grid
		t.drawGrid()
