# Basic Operation
class FormGetOperation

	# @property [String]
	@MESSAGE: "FormGetRequestMessage"


	# Generate the model for the message
	# @return [Object], Generated model
	model: ->
		RequestId = @api.getType("RequestId")
		new RequestId(@query.requestId)


	process: -> 
		
		"request": -> 
			itemId:             @find("item-id").val
			flowId:             @find("flow-id").val  
			requestId:          @find("request-id").val
			creator:            @find("creator").val
			requester:          @find("requester").val
			requesterRole:      @find("requester-role").val
			organizationalUnit: @find("organizational-unit").val
			createdByAssistant: @find("created-by-assistant").val
			isDraft:            @find("is-draft").val
		
		

module.exports = FormGetOperation