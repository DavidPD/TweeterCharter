express = require 'express'
connectCS = require 'connect-coffee-script'
fs = require 'fs'
Twit = require 'twit'
moment = require 'moment'

# load twitter credintials from a file.
twitterConfig = fs.readFileSync 'twitterconfig.json', { encoding: 'utf-8' }

twitter = new Twit (JSON.parse twitterConfig)

app = express()

app.get '/tweets', (req, res) -> 
	twitter.get 'statuses/user_timeline', 
		{screen_name: req.query.user, trim_user: true, count: 200}, 
		(err, data) ->
			if err then res.send err
			else 
				days = {}

				# for every day last week...
				for day in ([0..6].map (i) -> (moment().subtract 'd', i).format 'MM/DD/YYYY')
					days[day] = 0

				# get the date of every tweet the user posted
				dates = data.map (t) -> (moment new Date t.created_at).format 'MM/DD/YYYY'

				# count the number of dates for each day in the past week.
				for date in dates
					if days[date]? then days[date]++

				# send the result back as json.
				res.send days
				return days
			
app.use connectCS {
	src: "#{__dirname}/site/coffee"
	dest: "#{__dirname}/site/js"
	prefix: "/js"
	bare: true
}

app.use (express.static __dirname + '/site')

server = app.listen 3000, ->
	console.log "listening on port #{server.address().port}"