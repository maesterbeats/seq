@Euclid = (pulses,steps)->
	rotateTo = (a,ii)->
		if ii > 0
			for i in [0...ii]
				x = a.shift()
				a.push x
		else if ii < 0
			for i in [0...ii]
				x = a.shift()
				a.push x
		return a

	euclid = (pulses, steps)->

		steps = Math.round(steps)
		pulses = Math.round(pulses)

		if pulses > steps || pulses == 0 || steps == 0
			return new Array()

		pattern = []
		counts = []
		remainders = []
		divisor = steps - pulses
		remainders.push pulses
		level = 0

		while true
			counts.push Math.floor(divisor / remainders[level])
			remainders.push divisor % remainders[level]
			divisor = remainders[level]
			level += 1
			if remainders[level] <= 1
				break

		counts.push divisor
		r = 0

		build = (level)->
			r++
			if level > -1
				for i in [0...counts[level]]
					build level-1
				if remainders[level] isnt 0
					build level-2
			else if level is -1
				pattern.push 0
			else if level is -2
				pattern.push 1

		build(level)
		rev = pattern.reverse()
		firstOne = rev.indexOf 1

		return rotateTo(rev, firstOne)

	formatBeat = (euc)->
		hits = (i for v,i in euc when v is 1).map (i)-> i
		accents = (i for v,i in euc when v is 0).map (i)-> i
		return [hits, accents]

	return formatBeat euclid(pulses,steps)
