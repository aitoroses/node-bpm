class GetTaskDetailsByIdOperation

	# @property [String]
	@MESSAGE: "GetTaskDetailsByIdMessage"

	# @property [String]
	#@METHOD: "POST"

	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		WorkflowContext = @api.getType("WorkflowContext")
		Credential = @api.getType("Credential")
		TaskDetailsByIdRequest = @api.getType("TaskDetailsByIdRequest")

		credential = if @args.login? then new Credential(@args.login, @args.password) else new Credential
		workflow = new WorkflowContext(@args.token, credential)
		
		new TaskDetailsByIdRequest workflow, @args.taskId


	# Return some nodes on the response
	process: -> true


module.exports = GetTaskDetailsByIdOperation