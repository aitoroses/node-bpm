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
		# Get the attributes of the request
		login    = req.query.login
		password = req.query.password
		
		Credential = @api.getType("Credential")
		@credential = new Credential(login,password)

		# At this point we should query something to the BPM server
		@request (err, response, body)->
			res.end(body)
		


	###
	# @method to check the message that we are sending to the BPM engine
	#
	# @param {Request} req, request object
	# @param {Response} res, respose object
	#
	###
	stubData: (req, res) ->
		# Get the atributtes of the request
		login    = req.query.login
		password = req.query.password
		
		Credential = @api.getType("Credential")
		this.credential = new Credential(login,password)

		# Check the returned message

		return @message()


module.exports = AuthenticateOperation