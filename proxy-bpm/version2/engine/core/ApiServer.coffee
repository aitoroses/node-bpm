ApiEngine     = require "./ApiEngine"
utils         = require "../utils/ApiUtils"
log           = require "../utils/ApiLogger"
Express       = require "Express"
ServerUtils   = require "../utils/ServerUtils"


# ApiServer class creates a server
#
class ApiServer

	###
	# Construct an HTTP Server based on the API inside the engine
	#
	###
	constructor: (serverURL) ->

		@serverURL = "http://" + serverURL

		log.cut()

		@http = Express()

		@_engine = new ApiEngine();
		log.cut()
		# Initialize the API operations
		apis = @_engine.getAllAPI()
		log.header("Initializing API Server...")
		for id,api of apis
			@_registerAPI(api)


	###
	# Inner method to register an API, mapping it's operations to HTTP handlers
	#
	# @param {ApiManager} api, API server is gonna register
	#
	###
	_registerAPI: (api) ->

		# Reference to server into the api
		api._server = @

		name = api.getName()
		operations = api._operations

		for operation in operations

			_handlers.call(@, api, operation)


	###
	# Make the server listel to requests
	#
	# @port {Integer} port, Port to listen on
	#
	###
	listen: (port) ->
		@http.listen(port, ->
			log.cut()
			log.header("Server finished starting, listening on port #{port}")
		)


###
# Register handlers for each api operation
#
# @method
#
# @param {Object} operation, operation object
#
###
_handlers = (api, operation) ->

	base = "/#{api.getName()}/#{operation.id}"
	log.log("GET #{base}")

	op = new operation.content()

	handlerObjects = [

		url: ""
		handler: op.callback
	,	
		url: "/stub"
		handler: (req, res) -> res.end(op.stubData(req, res));
		debug: true
	,
		url: "/request"
		handler: ->
		debug: true
	,
		url: "/response"
		handler: ->
		debug: true
	]

	handlerObjects.map ((handlerObject) ->

		_url = handlerObject.url
		# Set the context for the handler
		_handler = handlerObject.handler.bind(op)

		# Set up context variables
		op.api = api
		# Give the request method to the context
		op.request = _request.bind(op)

		# Register as a GET method
		if handlerObject.debug
			if api.config.debug
				log.irrelevant "Debug GET #{base + _url}"
				@http.get(base + _url, _handler)
		else
			@http.get(base + _url, _handler)


	).bind(@)




###
# It's a helper method used by the handler of a operations
# Checks for the existance of config prop in the api and if it has a message method
# Sends to the BPM server the operations message
#
# @method
#
# @param {Function} callback, the callback function that holds the result.
# @option {Object} err, error returned by the response
# @option {Object} response, response object of the request
# @option {Object} body, the body of the response, usually the message
#
#
###
_request = (callback) ->

	# Has it's configuration have uri?
	if not @api.config.uri? then throw Error("No uri attribute was defined in config.")
	_uri = @api._server.serverURL + @api.config.uri

	# Is there a message() method?
	if not @message? then throw Error("No message function was defined.")
	_message = @message()

	# Make the request and process it
	ServerUtils.makeSoapRequest(_uri, _message, callback)




module.exports = ApiServer

