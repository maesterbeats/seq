@drawTrack = (paper, inst)->
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
