# Basic Operation
class RequestGetOperation

	# @property [String]
	@MESSAGE: "RequestGetMessage"


	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		RequestId = @api.getType("RequestId")
		new RequestId(@args.requestId)


	process: -> true
		

module.exports = RequestGetOperation