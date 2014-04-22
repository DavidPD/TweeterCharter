class Chart
	constructor: (@canvas, @values) ->

	draw: ->
		maxValue = 0
		for key, value of Object
			if value > maxValue then maxValue = value

		