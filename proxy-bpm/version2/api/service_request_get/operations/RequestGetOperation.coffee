# Basic Operation
class RequestGetOperation

	# @property [String]
	@MESSAGE: "RequestGetMessage"


	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		RequestId = @api.getType("RequestId")
		new RequestId(@args.requestId)


	process: -> true
		
		# "request": -> 
		# 	itemId:             @find("item-id").val
		# 	flowId:             @find("flow-id").val  
		# 	requestId:          @find("request-id").val
		# 	creator:            @find("creator").val
		# 	requester:          @find("requester").val
		# 	requesterRole:      @find("requester-role").val
		# 	organizationalUnit: @find("organizational-unit").val
		# 	createdByAssistant: @find("created-by-assistant").val
		# 	isDraft:            @find("is-draft").val
		# 	fields: ((field) -> 
		# 		return {
		# 			name: field.children[0].val
		# 			value: field.children[1].val
		# 		}
		# 	)(field) for field in @find("fields").children
		
		

module.exports = RequestGetOperation