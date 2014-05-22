# Basic Operation
class FormGetOperation

	# @property [String]
	@MESSAGE: "FormGetMessage"


	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		FormGet = @api.getType("FormGet")
		new FormGet(@args.requestId, @args.currentStepId)


	process: -> true
		

module.exports = FormGetOperation