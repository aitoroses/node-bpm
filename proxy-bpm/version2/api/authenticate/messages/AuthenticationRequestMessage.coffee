# RequestAuthenticationMessage class
#
class AuthenticationRequestMessage

	# Name of the XML template of AuthenticationRequestMessage
	@TEMPLATE: "authenticationRequestMessage"

	# Construct new Request
	#
	# @param {Credential} credential, the login name of the user
	#
	constructor: (@credential) ->


module.exports = AuthenticationRequestMessage