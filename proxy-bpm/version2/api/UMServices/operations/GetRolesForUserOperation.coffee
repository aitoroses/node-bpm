class GetRolesForUserOperation

	# @property [String]
	@MESSAGE: "GetRolesForUserMessage"

	model: ->
		UserType = @api.getType("User")
		new UserType(@args.user)

	describe: ->
		{
			"user": "comdirector15"
		}

	# Transform the request
	process: -> 

		Roles: -> @node.children.map (role) -> role.children[0].val


module.exports = GetRolesForUserOperation