$ -> # page loaded
	($ '#searchButton').on 'click', ->
		window.location.href = "/?user=#{($ '#usernameField').val()}"
		return