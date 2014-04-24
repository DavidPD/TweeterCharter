class Chart
	constructor: (@canvas, @values) ->
		@ctx = @canvas.getContext '2d'
		@height = @canvas.height - 40
		@width = @canvas.width - 40

		@ctx.translate 20, 20

		@maxValue = 0
		@points = []
		for value, i in @values
			if value.count > @maxValue then @maxValue = value.count
			@points.push {
				x: @width / (@values.length - 1) * i,
				y: @height - (value.count / @maxValue) * @height }

		($ canvas).on 'mousemove', (e) => @mouseMoved e
		($ canvas).on 'mouseout', (e) => @mouseOut e

	draw: ->

		@clearCanvas()

		@ctx.beginPath()

		###for value, i in @values
			x = @width / @values.length * i
			y = @height - (value.count / @maxValue) * @height
			@ctx.lineTo x, y###

		for point in @points
			@ctx.lineTo point.x, point.y

		@ctx.strokeStyle = 'black'
		@ctx.lineWidth = 3
		@ctx.stroke()

	clearCanvas: ->
		@ctx.clearRect -20, -20, @canvas.width, @canvas.width

	mouseMoved: (e) ->
		pos = @getParentOffset e
		pos.x -= 20
		pos.y -= 20

		pointDiffs = @points.map (p) -> Math.abs (p.x - pos.x)
		nearestPointIndex = pointDiffs.indexOf(pointDiffs.min())
		nearestPoint = @points[nearestPointIndex];
		nearestCount = @values[nearestPointIndex].count

		@draw()

		@ctx.beginPath()
		@ctx.moveTo nearestPoint.x, 0
		@ctx.lineTo nearestPoint.x, @height
		@ctx.strokeStyle = 'grey'
		@ctx.lineWidth = 2
		@ctx.stroke()

		@ctx.font = '15px sans-serif'
		@ctx.fillText nearestCount, (Math.clamp nearestPoint.x, 20, @width - 20), @height - @height / 2

	mouseOut: (e) ->
		@draw()

	getParentOffset: (e) -> 
		parentOffset = ($ @canvas).parent().offset()

		x: e.pageX - parentOffset.left, y: e.pagY - parentOffset.top