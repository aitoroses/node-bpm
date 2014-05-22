class FormUpdate

	@TEMPLATE: "formUpdate"

	# @param [String] @requestId
	# @param [Array<Object>] @categories
	constructor: (@requestId, @categories) ->

		# - category: Object
		#     - title: String
		#     - fields: Array<Object>
		#         - name: String
		#         - value: String


module.exports = FormUpdate