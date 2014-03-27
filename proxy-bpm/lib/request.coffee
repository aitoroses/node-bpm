request = require('request')
xmldoc  = require('xmldoc')
templates = require "./templates"
Config = require "./config"

# Add something for debugging requests

makeSoapRequest = (uri, templateName, data, callback) ->

	bodyBuilder = templates(templateName)
	body = bodyBuilder(data)
	if Config.debug.request
		console.log("<--------- Request --------->\n")
		console.log(body)
		console.log("\n<--------------------------->\n")

	wrap = (err, response, body) ->

		# Wrap the response with a log
		if Config.debug.response
			console.log("<--------- Response --------->\n")
			console.log(body)
			callback(err, response, body)
			console.log("\n<--------------------------->\n")
		else callback(err, response, body)


	request(
		method: 'POST',
		uri: uri
		headers: {"Content-Type": "text/xml"}
		body: body
	, wrap)

module.exports = makeSoapRequest