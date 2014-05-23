class FormUpdate

	@TEMPLATE: "formUpdate"

	# @param [String] @requestId
	# @param [Array<Object>] @categories
	constructor: (@requestId, @categories, @attachments) ->

		# - category: Object
		#     - title: String
		#     - fields: Object<Iterator>
		#         - fieldId: value


module.exports = FormUpdate
