xmldoc  = require('xmldoc')

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

exports.findNode = findNode
exports.getBody = getBody