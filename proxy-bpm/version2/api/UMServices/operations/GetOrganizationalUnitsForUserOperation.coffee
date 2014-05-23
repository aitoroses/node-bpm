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

	test: 
		args: 
			user: "comdirector15"
		
		expect: 

			"Small test" : (result) ->

				@assert.equal(true, true)
				@assert.equal(true, false)


module.exports = GetOrganizationalUnitsForUserOperation