# Basic Operation
class FormUpdateOperation

	# @property [String]
	@MESSAGE: "FormUpdateMessage"

	@METHOD: "POST"

	# Generate the model for the message
	# @return [Object], Generated model
	model: ->

		FormUpdate = @api.getType("FormUpdate")
		new FormUpdate(@args.requestId, @args.categories, @args.attachments)


	process: -> true

	# Describe how an api should be called
	describe: ->

		{
			"requestId": 16152,
			"categories": [
				{
					"title": "General",
					"fields": {
						"creatorName": "comdirector15"
					}
				}
			],
			"attachments": [
				{
					"version": 1,
					"label": "asdfasdfasdf",
					"fileName": "ACLEntry.data",
					"description": "asdfasdfa",
					"location": "/tmp",
					"uploadedBy": "comdirector15"
				}
			]
		}
		

module.exports = FormUpdateOperation