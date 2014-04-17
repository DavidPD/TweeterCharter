express = require 'express'
app = express()

app.get '/hello.txt', (req, res) ->
	res.send 'Hello World!'

module.exports.run = ->
	server = app.listen 3000, ->
		console.log "listening on port #{server.address().port}"