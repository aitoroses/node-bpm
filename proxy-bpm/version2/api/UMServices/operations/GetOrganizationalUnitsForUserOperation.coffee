class GetOrganizationalUnitsForUserOperation

	# @property [String]
	@MESSAGE: "GetOrganizationalUnitsForUserMessage"

	model: ->
		UserType = @api.getType("User")
		new UserType(@args.user)

	describe: ->
		{
			"user": "comdirector15"
		}

	# Transform the request
	process: ->

		OrgUnits: -> @node.children.map (org) -> org.children[0].val


module.exports = GetOrganizationalUnitsForUserOperation