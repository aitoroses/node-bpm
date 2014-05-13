# Operation for sending authentication
#
class AuthenticateOperation

	###
	# Construct new Request
	#
	# @param {Credential} credential, credentials of the user
	#
	###
	constructor: (@credential) ->

	###
	# Builds the message of the operation
	#
	# @return {AuthenticationMessage}
	#
	###
	message: () ->

		AuthenticationMessage = @api.getMessage("AuthenticationRequestMessage")

		authenticationMessage = new AuthenticationMessage(@credential)

		return authenticationMessage.toXML()

	###
	# Callback for the HTTP request
	#
	# @param {Request} req, request object
	# @param {Response} res, respose object
	#
	###
	callback: (req, res) ->

		# Get the atributtes of the request
		login    = req.query.login
		password = req.query.password
		
		Credential = @getType("Credential")
		op = new AuthenticateOperation(new Credential(login,password))

		console.log(op.message())


module.exports = AuthenticateOperation