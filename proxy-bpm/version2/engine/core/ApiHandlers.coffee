ServerUtils   = require "../utils/ServerUtils"
log   = require "../utils/ApiLogger"
finder = ServerUtils.findNode
transform = ServerUtils.transformNode


# Class that provides handlers to the ApiServer API register
#
# The context for each function should always be the same
# 
# - [ApiManager] this.api, a reference to the api object
# - [Object] this.operation, the instance of the operation
# 
class ApiHandlers

	# The detault handler for the operation
	# It processes the message returned from the BPM engine and gives the result
	# The process function should be the member of the operation and can return an object or an array
	@default: (req, res) ->

		# Api Describe?
		if req.args.describe_api
			if @operation.describe? then return res.json(@operation.describe())
			else return res.json({error: "Not API Description"})

		# Define first the context
		_request.call({
			api: @api
			message: => _getMessage.call(@, req.args, req, res)
		
		}, (err, response, body) =>
				
			if err
				return res.json(err)
			else
				xmldoc = ServerUtils.getBody(body)
				nodes = @operation.process.call(body, req, res, response)

				if typeof nodes is "object" # array of an object
					# If nodes it's an array
					if nodes.length?
						processedNodes = nodes.map((node) -> 
							result = finder(node, xmldoc)
							if result?
								result.firstChild = result.lastChild = undefined
							return result
						)
					else
						# If nodes it's a hash
						processedNodes = {}
						for node,fn of nodes
							
							finded = finder(node, xmldoc)
							finderFn = (node) -> finder(node, finded)

							key = node.split(":")
							key = if key.length == 2 then key[1] else key[0]
							# Call process func passing especific utils
							result = fn.call({find: finderFn, node: finded, finder: finder})
							if result?
								delete result.firstChild
								delete result.lastChild
							processedNodes[key] = result

					res.json(processedNodes)

				# Transform the node if it is true
				else if typeof nodes is "boolean" and nodes then res.json(transform(xmldoc.children[0]))
				
				else res.json({error: nodes})
		)




	# Handler method returns the model constructed by the operation with the params
	@model: (req, res) ->
		res.json _getModel.call(@, req.args, req, res)




	# Handler method to get the XML representation of the model
	@modelXML: (req, res) ->
		# Get the model
		model = _getModel.call(@, req.args, req, res)
		# Don't use "application/xml" content-type
		res.end(model.toXML())



	# Handler method to get the XML representation of the model
	@request: (req, res) ->
		body = _getMessage.call(@, req.args, req, res)
		res.header({"Content-Type": "text/xml"})
		res.end(body)

	# Handler method to get the XML representation of the model
	@node: (req, res) ->

		# Define first the context
		_request.call({
			api: @api
			message: => _getMessage.call(@, req.args, req, res)
		
		}, (err, response, body) =>
				
			if err
				return res.json(err)
			else
				xmldoc = ServerUtils.getBody(body)
				res.json(xmldoc)
		)


	# Handler method that returns the exact message given by the BPM engine
	@response: (req, res) ->
		# Define first the context
		_request.call({
			api: @api
			message: => _getMessage.call(@, req.args, req, res)
		
		}, (err, response, body) =>
			if err
				return res.json(err)
			else
				JSONResponse = @operation.process.call(body)
				res.header({"Content-Type": "text/xml"})
				res.end(body)
		)


# Use the operations model() method to construct the model object
# @param [Object] args the args object to retrieve from the URL
# @return [Object] the model object of the operation
_getModel = (args, req, res) ->
	data = @operation.model.call({api: @api, args: args}, req, res);




# Model process to get the XML representation of the model
# @param [Object] args, the args object to retrieve from the URL
# @return [String], the XML chunk of the message that is gonna be sended to the BPM engine
_getMessage = (args, req, res) ->
	model = _getModel.call(@, args, req, res)
	modelXML = model.toXML();
	# Get the Message
	Message = @api.getMessage(@operation.constructor.MESSAGE)
	# Instantiate the message
	if not Message? 
		log.irrelevant("You must define a valid #{@operation.constructor.name}.MESSAGE Attribute")
		return
	message = new Message(model)
	message.toXML()


# It's a helper method used by the handler of a operations
# Checks for the existance of config prop in the api and if it has a message method
# Sends to the BPM server the operations message
# @param [Function] callback, the callback function that holds the result.
# @option callback [Object] err Error returned by the response
# @option callback [Object] Eesponse response object of the request
# @option callback [Object] Body the body of the response, usually the message
_request = (callback) ->

	# Has it's configuration have uri?
	if not @api.config.uri? then throw Error("No uri attribute was defined in config.")
	_uri = @api._server.serverURL + @api.config.uri

	# Is there a message() method?
	if not @message? then throw Error("No message function was defined.")
	_message = @message()

	# Make the request and process it
	ServerUtils.makeSoapRequest(_uri, _message, callback)




module.exports = ApiHandlers