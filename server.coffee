express = require 'express'
connectCS = require 'connect-coffee-script'
fs = require 'fs'

app = express()

indexpage = null

app.use connectCS {
	src: "#{__dirname}/site/coffee"
	dest: "#{__dirname}/site/js"
	prefix: "/js"
	bare: true
}

app.use (express.static __dirname + '/site')


server = app.listen 3000, ->
	console.log "listening on port #{server.address().port}"