# Operation for sending authentication
class AuthenticateOperation

	# @property [String]
	@MESSAGE: "AuthenticationRequestMessage"

	# @property [String]
	#@METHOD: "POST"

	# Generate the model for the message
	# @return [Object], Generated model
	model: (req, res) ->
		Credential = @api.getType("Credential")
		new Credential(@args.login, @args.password)



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
	process: (req, res, response) -> 
		"workflowContext": -> 
			# Remember Cookie
			res.cookie("adfbridge.token", @find("token").val, {maxAge: 900000, httpOnly: false})
			return {
				credential:
					login: @find("login").val
					identityContext: @find("identityContext").val
				token: @find("token").val
				locale: @find("locale").val
				timeZone: @find("timeZone").val
			}

	# API testing
	test: 
		args: 
			login: "comdirector15"
			password: "welcome1"
		
		expect: 
			"should return workflowContext" : (result) ->
				result.workflowContext.should.be.a "object"

			"should have a login" : (result) ->
				result.workflowContext.credential.login.should.be.a "string"
				
			"should have a token" : (result) ->
				result.workflowContext.token.should.be.a "string"
	
	

module.exports = AuthenticateOperation