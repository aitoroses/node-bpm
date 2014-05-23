class GetAllRolesOperation

	# @property [String]
	@MESSAGE: "GetAllRolesMessage"

	# Transform the request
	process: -> 

		"Roles": -> 
			@node.children.map (child) ->
				return child.children[0].val


module.exports = GetAllRolesOperation