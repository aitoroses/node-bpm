class Operation

	# @property [String]
	@MESSAGE: "DefaultMessage"

	# Return the model data for the Message template
	model: ->
		UserType = @api.getType("User")
		new UserType(@args.user)


	# Api description using JSON response
	describe: ->
		params: [
			"user {String}": "The user to retrieve Organizational Units for."
		]
		example: 
			user: "comdirector15"


	# Transform the request
	# There are alternative ways on doing this
	# Returning, "Boolean", "Array", or Hash Object
	process: ->

		OrgUnits: -> @node.children.map (org) -> org.children[0].val



	# Enables testing the Operation through Mocha
	# It creates request's with several expectations
	test: 
		args: 
			user: "comdirector15"
		
		expect: 
			"should have OrgUnits" : (result) ->
				result.should.have.property "OrgUnits"

			"Orgunits should be an Array" : (result) ->
				result.OrgUnits.should.be.a "array"
				

module.exports = Operation