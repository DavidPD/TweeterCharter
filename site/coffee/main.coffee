$ -> # page loaded
	($ '#searchButton').on 'click', ->
		($.get "/tweets", {user: ($ '#usernameField').val()}).done (data) ->
			