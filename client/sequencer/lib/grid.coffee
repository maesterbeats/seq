@makeGrid = (svgElement)->
	s = Snap(svgElement)
	console.log s
	drawGrid = ->
		s.clear()
		invertCell = (grid, row, col)->
			val = grid[row][col]
			grid[row][col] = !val
			return grid

		isActive = (r,c)->
			x = Session.get("grid")[r][c]
			if x is on
				if (c % 4) is 0
					{fill: "#E1EDB1",stroke: "#3C94EE",strokeWidth: 3.0}
				else
					{fill: "#E1EDB1",strokeWidth: 2.0, stroke: "#3C94EE"}
			else if (c % 4) is 0
				{fill: "#B5E5DC",stroke: "#3C94EE",strokeWidth: 0.5}
			else
				{fill: "#B5E5DC", strokeWidth: 0.5,stroke: "#3C94EE"}

		rad = 2
		grid = Session.get "grid"
		scale = 31
		width = scale * 0.8
		height = scale * 0.5
		marg = 15
		active = {fill: "#E1EDB1"}
		inActive = {fill: "#406F92"}
		GRID = for row, y in grid
			dy = y * scale * 0.75 + marg
			for col, x in row
				dx = x * scale + marg
				if x % 4 is 0
					h = height
				else
					h = height * 0.85
				cell = s.rect(dx, dy, width, h, rad, rad)
				.attr(isActive(y,x))
				.data("i", [y,x])
				.click ->
					console.log this.data("i")
					grid = Session.get "grid"
					cell = this.data("i")
					newGrid = invertCell(grid,cell[0],cell[1])
					Session.set "grid", newGrid
					s.clear()
					drawGrid()
				cell.attr

