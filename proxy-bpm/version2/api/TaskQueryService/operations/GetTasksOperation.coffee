class GetTasksOperation

	# @property [String]
	@MESSAGE: "GetTasksMessage"

	# @property [String]
	#@METHOD: "POST"

	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		WorkflowContext = @api.getType("WorkflowContext")
		Credential = @api.getType("Credential")
		credential = if @args.login? then new Credential(@args.login, @args.password) else new Credential
		new WorkflowContext(@args.token, credential)



	# Return some nodes on the response
	process: -> 
		"taskListResponse": -> @node

module.exports = GetTasksOperation