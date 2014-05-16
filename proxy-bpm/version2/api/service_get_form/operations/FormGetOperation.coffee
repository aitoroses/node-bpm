# Basic Operation
class FormGetOperation

	# @property [String]
	@MESSAGE: "FormGetRequestMessage"


	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		RequestId = @api.getType("RequestId")
		new RequestId(@query.requestId)


	process: -> 
		request: -> @find("request")
		

	
module.exports = FormGetOperation