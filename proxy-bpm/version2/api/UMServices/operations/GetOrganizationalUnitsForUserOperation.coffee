class GetOrganizationalUnitsForUserOperation

	# @property [String]
	@MESSAGE: "GetOrganizationalUnitsForUserMessage"

	model: ->
		UserType = @api.getType("User")
		new UserType(@args.user)

	# Api description
	describe: ->
		params: [
			"user {String}": "The user to retrieve Organizational Units for."
		]
		example: 
			user: "comdirector15"

	# Transform the request
	process: ->

		OrgUnits: -> @node.children.map (org) -> org.children[0].val

	# Enables testing the Operation through mocha
	test: 
		args: 
			user: "comdirector15"
		
		expect: 

			"should have OrgUnits" : (result) ->
				result.should.have.property "OrgUnits"

			"Orgunits should be an Array" : (result) ->
				result.OrgUnits.should.be.a "array"
				

module.exports = GetOrganizationalUnitsForUserOperation