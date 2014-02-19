Template.grid.rendered = ->
	svgElement = document.getElementById("svg")
	console.log drawUtils
	drawGrid = makeGrid(svgElement)
	drawUtils['drawGrid'] = drawGrid
	drawUtils.drawGrid()

