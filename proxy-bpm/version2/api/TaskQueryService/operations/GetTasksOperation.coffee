class GetTasksOperation

	# @property [String]
	@MESSAGE: "GetTasksMessage"

	# @property [String]
	#@METHOD: "POST"

	# Generate the model for the message
	# @return [Object], Generated model
	model: (req) ->
		WorkflowContext = @api.getType("WorkflowContext")
		Credential = @api.getType("Credential")
		credential = if @args.login? then new Credential(@args.login, @args.password) else new Credential
		
		# Session?
		token = @args.token || req.cookies["adfbridge.token"]
		new WorkflowContext(token, credential)


	# Transform the request
	process: -> true


module.exports = GetTasksOperation