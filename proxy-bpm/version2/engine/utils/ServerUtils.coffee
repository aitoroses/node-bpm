async    = require "async"
log      = require "../utils/ApiLogger"
xmldoc   = require('xmldoc')
request  = require('request')


# Class with useful static methods for manipulating request conversions
#  and sending requests to the BPM engine
class ServerUtils


	# Get a template for rendering contents
	# @param [String] nodeName node that we want to find
	# @param [XMLDoc] xml xmldoc converted message
	# @return [XMLDoc] return the node that we searched
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
			return {val: null, attr: [], name: null, children: []}
		if xml?
			if xml.name is nodeName then return xml
			else return iterateOverChildren(xml.children)
		else {val: null, attr: [], name: null, children: []}
	

	# Transform a node's content to it's resultant JSON
	# @param [String] nodeName node that we want to find
	# @return [Object] Resulting JSON object
	@transformNode = (node) ->
		iterate = (node, step) ->
			# If this node has not children iteration has finished
			if node.children.length is 0 
				step[node.name] = node.val
				return step
			else
				# We have some childs at this point
				result = {}
				node.children.map((child) -> iterate(child, result))
				step[node.name] = result
				return step	
		result = iterate(node, newStep = {})
		if result[node.name] is "" then return {error: "Empty response."}
		else return result

	# Get the body of the xml document
	# @param [String] xml XML pure string to be converted
	# @return [XMLDoc] xmldoc converted message
	@getBody: (xml) ->
		document = new xmldoc.XmlDocument(xml);
		return document.children[1]


	# Send a message to the BPM engine
	# @param [String] uri The URL to send the message to
	# @param [String] message XML pure string message to be sended
	# @param {Function} callback return function with this params (err, response, body)
	# @return [XMLDoc] xmldoc converted message
	@makeSoapRequest: (uri, message, callback) ->
		request(
			method: 'POST',
			uri: uri
			headers: {"Content-Type": "text/xml"}
			body: message
		, callback)



module.exports = ServerUtils