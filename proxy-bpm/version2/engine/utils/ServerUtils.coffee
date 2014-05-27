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
		class NodeRunner
			constructor: (@node, @parent) ->
				@child = 0  
			hasMore: -> @child < @node.children.length
			hasChild: -> @node.children.length > 0
			next: () ->
				node = new NodeRunner(@node.children[@child], @)
				@child = @child+1
				return node
			getVal: () ->
				@node.val
			getName: () ->
				processTag(@node.name)
			getAttrs: () -> @node.attr
			getParent: -> @parent

		firstNode = new NodeRunner(node)
		result = {}

		processTag = (tagName) -> 
			tags = tagName.split(":")
			tag = if tags.length > 1 then tags[1] else tags[0]

		iterateNode = (node, step) ->
			if not node.hasChild() 
			  if Object.keys(node.getAttrs()).length > 0 then step[node.getName() + "Attrs"] = node.getAttrs()
			  step[node.getName()] = node.getVal()
			else
				step[node.getName()] = []
				if Object.keys(node.getAttrs()).length > 0 then step[node.getName() + "Attrs"] = node.getAttrs()
				step[node.getName()].push {}
				while node.hasMore()
					next = node.next()
					if next.hasChild() then step[node.getName()].push {} # causes artifacts
					iterateNode(next, step[node.getName()][step[node.getName()].length-1])
				# Delete empty objects in arrays caused by algorithm (the first object)
				if Object.keys(step[node.getName()][0]).length is 0 then step[node.getName()].shift()


				
		iterateNode(firstNode, result)

		return result
		

	# Get the body of the xml document
	# @param [String] xml XML pure string to be converted
	# @return [XMLDoc] xmldoc converted message
	@getBody: (xml) ->
		document = new xmldoc.XmlDocument(xml);
		if not document.children[1]? then return document.children[0]
		else return document.children[1]


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
			jar: true
		, callback)



module.exports = ServerUtils