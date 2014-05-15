# Operation for sending authentication
#
class AuthenticateOperation

	@MESSAGE: "AuthenticationRequestMessage"

	###
	# Construct new Operation
	#
	# @param {Credential} model, credentials of the user
	#
	###
	constructor: (@credential) ->


	###
	# Return the model for the message
	#
	# @return {Object}, Model object type
	#
	###
	model: ->
		Credential = @api.getType("Credential")
		new Credential(@query.login, @query.password)


	# ###
	# # Return some nodes on the response
	# #
	# # @return {Array<Strings>}, Array of node names to be processed
	# #
	# ###
	# process: -> ["faultcode", "message"]

	###
	# Return some nodes on the response
	#
	# @return {Array<Strings>}, Array of node names to be processed
	#
	###
	process: -> 
		"com:workflowContext": -> 
			credential: 
				login: @find("com:login").val
				password: @find("com:password").val
			token: @find("com:token").val
			locale: @find("com:locale").val
			timezone: @find("com:timeZone").val
	



module.exports = AuthenticateOperation