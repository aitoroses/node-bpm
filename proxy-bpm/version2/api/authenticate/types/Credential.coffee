# Credential class

class Credential

	# Name of the XML template of credential
	@MESSAGE: "Credential"

	# Construct new credentials
	#
	# @param [String] login, the login name of the user
	# @param [String] password, the password of the user
	#
	constructor: (@login, @password) ->

module.exports = Credential