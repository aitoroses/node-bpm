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

		_this = @

		name = api.getName()
		operations = api._operations

		for operation in operations
			log.log("GET /#{name}/#{operation.id}")
			handler = new operation.content()

			# Set up context variables
			handler.api = api

			# Give the request method to the context
			handler.request = (callback) ->
				if not api.config.uri? then throw Error("No uri attribute was defined in config.")
				_uri = _this.serverURL + api.config.uri

				if not @message? then throw Error("No message function was defined.")
				_message = @message()

				ServerUtils.makeSoapRequest(_uri, _message, callback)

			# Register HTTP handlers for the API
			@http.get("/#{name}/#{operation.id}", handler.callback.bind(handler))

			# Stub data
			if (handler.stubData?)
				@http.get("/#{name}/#{operation.id}/stub", (req, res) -> 
					res.end(handler.stubData.bind(handler)(req, res)));


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


module.exports = ApiServer

