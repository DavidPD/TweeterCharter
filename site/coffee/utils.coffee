if !Array.max then Array.max = (array) ->
	Math.max.apply Math, array

if !Array.min then Array.min = (array) ->
	Math.min.apply Math, array

if !Array.prototype.max then Array.prototype.max = ->
	Array.max this

if !Array.prototype.min then Array.prototype.min = ->
	Array.min this

if !Math.clamp then Math.clamp = (num, min, max) ->
	Math.max min, (Math.min max, num)