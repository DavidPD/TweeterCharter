express = require 'express'
connectCS = require 'connect-coffee-script'
fs = require 'fs'
Twit = require 'twit'

twitterConfig = fs.readFileSync 'twitterconfig.json', { encoding: 'utf-8' }

twitter = new Twit (JSON.parse twitterConfig)

app = express()

indexpage = null

app.get '/tweets', (req, res) -> 
	twitter.get 'statuses/user_timeline', 
		{screen_name: req.query.user, trim_user: true},
		(err, data) ->
			if err then res.send err
			else res.send data
			

app.use connectCS {
	src: "#{__dirname}/site/coffee"
	dest: "#{__dirname}/site/js"
	prefix: "/js"
	bare: true
}

app.use (express.static __dirname + '/site')

server = app.listen 3000, ->
	console.log "listening on port #{server.address().port}"