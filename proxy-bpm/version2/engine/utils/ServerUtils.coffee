fs	    = require "fs"
async   = require "async"
log     = require "../utils/ApiLogger"
xmldoc  = require('xmldoc')
request = require('request')


###
# Class with useful static methods for manipulating request conversions
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
	findNode: (nodeName, xml) ->
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

				
	getBody: (xml) ->
		document = new xmldoc.XmlDocument(xml);
		return document.children[1]


	makeSoapRequest: (uri, message, callback) ->

		request(
			method: 'POST',
			uri: uri
			headers: {"Content-Type": "text/xml"}
			body: message
		, callback)



module.exports = ServerUtils