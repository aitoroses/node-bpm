class WorkflowContext

	# Name of the XML template
	@TEMPLATE: "workflowContext"

	# Construct new WorkflowContext
	#
	# @param {String} token, the login name of the user
	constructor: (@token, @credential) ->


module.exports = WorkflowContext