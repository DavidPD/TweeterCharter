express = require 'express'
connectCS = require 'connect-coffee-script'
fs = require 'fs'
Twit = require 'twit'
moment = require 'moment'

# load twitter credintials from a file.
twitterConfig = fs.readFileSync 'twitterconfig.json', { encoding: 'utf-8' }

twitter = new Twit (JSON.parse twitterConfig)

app = express()

app.get '/tweetCount', (req, res) -> 
	twitter.get 'statuses/user_timeline', 
		{screen_name: req.query.user, trim_user: true, count: 200}, 
		(err, data) ->
			if err then res.send err
			else 
				numDays = 7
				# Create a zero-filled array.
				# Each value in the array represents the count of tweets for that many days ago
				days = [0..numDays - 1].map (i) -> {day: ((moment().subtract 'days', i).format 'MM/DD/YYYY'), count:0} 

				# for every day last week, initialize the tweet count to 0;
				# for day in ([0..6].map (i) -> (moment().subtract 'd', i).format 'MM/DD/YYYY')
				# 	days[day] = 0

				# get the date of every tweet the user posted
				dates = data.map (t) -> (moment new Date t.created_at).format 'MM/DD/YYYY'

				dateDiffs = data.map (t) -> Math.abs ((moment new Date t.created_at).diff moment(), 'days')

				# count the number of dates for each day in the past week.
				# for date in dates
				# 	if days[date]? then days[date]++

				for diff in dateDiffs
					console.log diff
					if days[diff]? then days[diff].count++

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