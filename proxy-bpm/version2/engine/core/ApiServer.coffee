ApiEngine = require "./ApiEngine"
utils     = require "../utils/ApiUtils"
log       = require "../utils/ApiLogger"
Express   = require "Express"

# ApiServer class creates a server
#
class ApiServer

	###
	# Construct an HTTP Server based on the API inside the engine
	#
	###
	constructor: () ->

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

		name = api.getName()
		operations = api._operations

		for operation in operations
			log.log("GET /#{name}/#{operation.id}")
			handler = new operation.content
			@http.get("/#{name}/#{operation.id}", handler.callback.bind(api))


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

