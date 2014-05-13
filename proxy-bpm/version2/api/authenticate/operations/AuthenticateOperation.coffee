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


module.exports = AuthenticateOperation