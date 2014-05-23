# Basic Operation
class ApiOperation

	# @property [String]
	@MESSAGE: "DefaultRequestMessage"


	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		error: "Please override the Operation.model() method."
		toXML: (-> @message)



	# Return some nodes on the response
	# @return [Array<String>] Array of node names to be processed
	#
	# @example Returning an object or an array
	#   process: -> 
	# 	  "com:workflowContext": -> 
	# 		  credential: 
	# 			  login: @find("com:login").val
	# 			  password: @find("com:password").val
	# 		  token: @find("com:token").val
	# 		  locale: @find("com:locale").val
	# 		  timezone: @find("com:timeZone").val
	#
	#   ## Alternative Syntax
	#   # This way nodes are not processed and instead the entire nodes are returned
	#   # Does not use the namespace with this alternative syntax
	#   
	#   process: -> ["faultcode", "message"]
	#
	#   ## Best way syntax
	#   # With this syntax the entire message gets parsed in
	#   # Does not use the namespace with this alternative syntax
	#   
	#   process: -> true
	process: -> 
		"Please override the Operation.process() method."

	
module.exports = ApiOperation