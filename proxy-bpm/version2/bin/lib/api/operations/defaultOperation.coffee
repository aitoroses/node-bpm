class Operation

	# @property [String]
	@MESSAGE: "DefaultMessage"

	# Return the model data for the Message template
	model: ->
		UserType = @api.getType("User")
		new UserType(@args.user)


	# Api description using JSON response
	describe: ->
		params: [
			"user {String}": "The user to retrieve Organizational Units for."
		]
		example: 
			user: "comdirector15"


	# Transform the request
	# Return some nodes on the response
	# @return [Array<String>] Array of node names to be processed
	#
	# @example Returning an object or an array
	#   process: -> 
	# 	  "workflowContext": -> 
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

		OrgUnits: -> @node.children.map (org) -> org.children[0].val



	# Enables testing the Operation through Mocha
	# It creates request's with several expectations
	test: 
		args: 
			user: "comdirector15"
		
		expect: 
			"should have OrgUnits" : (result) ->
				result.should.have.property "OrgUnits"

			"Orgunits should be an Array" : (result) ->
				result.OrgUnits.should.be.a "array"
				

module.exports = Operation