Config = require './config'
request = require('./apiUtils').SoapRequest
findNode = require("./apiUtils").findNode
getBody = require("./apiUtils").getBody

services = {}

service_form_get = (requestId, currentStepId, callback) ->

	url = Config.baseUrl + "soa-infra/services/default/eAppServices/Service_Form_Get_ep?WSDL"

	template = "services/service_form_get"
	data =
		requestId: requestId
		currentStepId: requestId

	doProcess = (err, response, body) ->
		doc = getBody(body)
		data = findNode("ns0:form", doc)
		if data?
			callback(null, data)
		else 
			callback({
				msg: "Error in service_form_get"
			}, null)

	# Make soap request
	request(url, template, data, doProcess)



#########################
# App Requests          #
#########################

API = (app) ->

	app.get '/form/:requestId', (req,res) ->

		services.service_form_get req.params.requestId, -1, (err, form) ->

			if err
				console.log err
				res.json err
			else
				res.json form


# Export
services.API = API
services.service_form_get = service_form_get
module.exports = services