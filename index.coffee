###
Glue/server logic.

Lets event API handler modules determine what to do with any POSTed urls.
Lets the datahandler see what to do with any GET requests.

@author Torstein Thune
###

http = require 'http'
querystring = require 'querystring'
colors = require 'colors'
port = process.argv[2] || 8888 # port to start paraply on

frontend = require './frontend'
api = require './api'

#db = require './db'

# Handle post requests (e.g urls for adding events)
postHandler = (req, res) ->
	req.body = ''
	req.addListener('data', (chunk) ->
		req.body += chunk
	)

	req.addListener('error', (error) ->
		console.error('got a error', error)
	)

	req.addListener('end', (chunk) ->
		req.body += chunk if chunk

		url = decodeURIComponent(req.body)

		res.writeHead(200)
		res.end('{ "went": "ok" }')
	)

# Handle GET requests (e.g getting JSON)
getHandler = (req, res) ->
	frontend.handle(req, res)
	# res.writeHead(200)
	# res.write('Hello world!')
	# res.end()

# Wrapper for handling requests
requestHandler = (req, res) ->
	if req.method is 'GET'
		getHandler(req,res)
	else if req.method is 'POST'
		postHandler(req,res)

# Start the server
http.createServer(requestHandler).listen(parseInt(port, 10))

# Really important =D
console.log "\n\n\n
			yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyyy++yyyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyys  syyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyysssssso+.  .+ossssssyyyyyyyyyy\n
			yyyyyyy:`         `+/`         `:yyyyyyy\n
			yyyyyy+ `/ooooooosyyyysooooooo/` +yyyyyy\n
			yyyyyy: :yyyyyyyyys--oyyyyyyyyy: :yyyyyy\n
			yyyyyyo+syyyyyyyyyo  +yyyyyyyyys+oyyyyyy\n
			yyyyyyyyyyyyyyyyyyo  +yyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyyo  +yyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyys--oyyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyyy/:+yyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyyy` :yyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyyo .syyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyy.-yyyyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyys+yyyyyyyyyyyyyyyyyyyyy\n
			yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy\n"['red']
console.log ' Paraply started @ ' + "http://localhost:#{port}\n\n\n"['cyan']



