xmldoc  = require('xmldoc')
request = require('request')
_ = require('underscore');
Config = require "./config"


#########################
# TEMPLATES             #
#########################

compileTemplate = (name) ->
	return _.template(require("./templates/#{name}"))

compiler = (name) ->
	template = compileTemplate(name)

exports.compiler = compiler


#########################
# UTILS                 #
#########################

findNode = (nodeName, xml) ->
	iterateOverChildren = (children)->
		parents = []
		for child in children
			if child.name is nodeName
				return child
			else if child.children.length > 0
				parents.push(child)
		for parent in parents
			return iterateOverChildren(parent.children)
		return undefined
	if xml.name is nodeName then return xml
	else return iterateOverChildren(xml.children)
			
getBody = (xml) ->
	document = new xmldoc.XmlDocument(xml);
	return document.children[1]

makeSoapRequest = (uri, templateName, data, callback) ->

	bodyBuilder = compiler(templateName)
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

exports.SoapRequest = makeSoapRequest
exports.findNode = findNode
exports.getBody = getBody


