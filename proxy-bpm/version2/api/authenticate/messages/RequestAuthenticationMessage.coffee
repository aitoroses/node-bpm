class RequestAuthenticationMessage
	constructor: (@credential) ->
	get: ->
		"""
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:com="http://xmlns.oracle.com/bpel/workflow/common">
		<soapenv:Header/>
		<soapenv:Body>
			#{@credential.toXML()}
		</soapenv:Body>
		</soapenv:Envelope>
		"""

module.exports = RequestAuthenticationMessage