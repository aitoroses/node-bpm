# Basic Operation
class FormUpdateOperation

	# @property [String]
	@MESSAGE: "FormUpdateMessage"

	@METHOD: "POST"

	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		FormUpdate = @api.getType("FormUpdate")
		new FormUpdate(@args.requestId, @args.categories)


	process: -> true
		

module.exports = FormUpdateOperation