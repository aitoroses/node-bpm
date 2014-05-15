async    = require "async"
log      = require "../utils/ApiLogger"
xmldoc   = require('xmldoc')
request  = require('request')


###
# Class with useful static methods for manipulating request conversions
# and sending requests to the BPM engine
#
###
class ServerUtils


	###
	# Get a template for rendering contents
	# 
	# @method static
	#
	# @param {String} nodeName, node that we want to find
	# @param {XMLDoc} xml, xmldoc converted message
	#
	# @return {XMLDoc}, return the node that we searched
	#
	###
	@findNode: (nodeName, xml) ->
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


	###
	# Get the body of the xml document
	#
	# @param {String} xml, XML pure string to be converted
	#
	# @return {XMLDoc}, xmldoc converted message
	#
	###			
	@getBody: (xml) ->
		document = new xmldoc.XmlDocument(xml);
		return document.children[1]


	###
	# Send a message to the BPM engine
	#
	# @param {uri} uri, XML pure string to be converted
	# @param {String} message, XML pure string to be converted
	# @param {Function} callback, XML pure string to be converted
	#
	# @return {XMLDoc}, xmldoc converted message
	#
	###		
	@makeSoapRequest: (uri, message, callback) ->
		request(
			method: 'POST',
			uri: uri
			headers: {"Content-Type": "text/xml"}
			body: message
		, callback)



module.exports = ServerUtils