ApiEngine     = require "./ApiEngine"
utils         = require "../utils/ApiUtils"
log           = require "../utils/ApiLogger"
express       = require "Express"
ApiHandlers   = require "../core/ApiHandlers"

# Middleware
corsMiddleware = require "../middleware/cors"
requestArgumentsMixer = require "../middleware/requestArgumentsMixer"


# ApiServer class creates a server
class ApiServer

	# Construct an HTTP Server based on the API inside the engine
	# @param [String] serverURL Host where lives the BPM Engine
	constructor: (serverURL) ->

		@serverURL = "http://" + serverURL

		log.cut()

		@http = express()
		@http.configure =>
			@http.use express.logger('dev')
			@http.use express.cookieParser('my secret here')
			@http.use express.json()
			@http.use express.static(__dirname + '/app')
			@http.use corsMiddleware
			@http.use requestArgumentsMixer

		@_engine = new ApiEngine();
		log.cut()
		# Initialize the API operations
		apis = @_engine.getAllAPI()
		log.header("Initializing API Server...")
		for id,api of apis
			@_registerAPI(api)


	# Inner method to register an API, mapping it's operations to HTTP handlers
	# @param [ApiManager] api API server is gonna register
	# @private
	_registerAPI: (api) ->

		# Reference to server into the api
		api._server = @

		name = api.getName()
		operations = api._operations

		for operation in operations

			_handlers.call(@, api, operation)


	# Make the server listel to requests
	# @param [Integer] port Port to listen on
	listen: (port) ->
		@http.listen(port, ->
			log.cut()
			log.header("Server finished starting, listening on port #{port}")
		)


# Register handlers for each api operation
# @param [Object] operation Operation object
# @param [ApiManager] api ApiManager object
# @private
_handlers = (api, operation) ->

	base = "/#{api.getName()}/#{operation.id}"
	
	op = new operation.content()
	
	# METHOD
	if op.constructor.METHOD? and typeof op.constructor.METHOD is "string"
		_method = op.constructor.METHOD
	else _method = "GET"
	_method = _method.toLowerCase()

	log.log("#{_method.toUpperCase()} #{base}")
	if (api.config.debug) then log.irrelevant("#{@serverURL}#{api.config.uri}")

	handlerObjects = [

		url: ""
		handler: ApiHandlers.default
	,	
		url: "/model"
		handler: ApiHandlers.model
		debug: true
	,	
		url: "/modelXML"
		handler: ApiHandlers.modelXML
		debug: true
	,
		url: "/request"
		handler: ApiHandlers.request
		debug: true
	,
		url: "/response"
		handler: ApiHandlers.response
		debug: true
	]

	handlerObjects.map ((handlerObject) ->

		_url = handlerObject.url
		# Set the context for the handler
		_handler = handlerObject.handler.bind({api: api, operation: op})

		# Register as a GET method
		if handlerObject.debug
			if api.config.debug
				log.irrelevant "Debug GET #{base + _url}"
				@http.get(base + _url, _handler)
		else
			@http[_method](base + _url, _handler)


	).bind(@)


module.exports = ApiServer

