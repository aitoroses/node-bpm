# RequestAuthenticationMessage class
class AuthenticationRequestMessage

	# Name of the XML template of AuthenticationRequestMessage
	# @property [String]
	@TEMPLATE: "authenticationRequestMessage"

	# Construct new Request
	# @param [Credential] credential The credentials of the user
	constructor: (@credential) ->


module.exports = AuthenticationRequestMessage