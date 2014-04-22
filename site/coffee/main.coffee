chart = null

$ -> # page loaded
	($ '#searchButton').on 'click', ->
		($.get "/tweetCount", {user: ($ '#usernameField').val()}).done (data) ->
			chart = new Chart $ '#canvas', data
			chart.draw()