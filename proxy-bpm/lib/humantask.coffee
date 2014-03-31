Config = require './config'
request = require './request'
taskQueryServiceUrl = Config.baseUrl + "integration/services/TaskQueryService/TaskQueryService?WSDL"
findNode = require("./apiUtils").findNode
getBody = require("./apiUtils").getBody

humantask = {}

### Human Task Actions ###

authenticate = (login, password, callback) ->

	template = "authenticate"
	req =
		login: login
		password: password

	doProcess = (err, response, body) ->
		doc = getBody(body)
		data = doc.children[0]
		if data.name == "workflowContext"
			callback(null, {
				login: data.children[0].children[0].val
				identityContext: data.children[0].lastChild.val
				token: data.children[1].val
			})
		else 
			callback({
				msg: "Login was not returned"
			}, null)

	# Make soap request
	request(taskQueryServiceUrl, template, req, doProcess)

getTasks = (token, callback) ->

	template = "getTasks"
	req = {
		token: token
	}

	doProcess = (err, response, body) ->
		doc = getBody(body)
		data = doc.children[0]
		if data.name is "taskListResponse"
			tasks = data.children
			callback(null, tasks)
		else callback({
				msg: "Bad token."
			}, null)

	request(taskQueryServiceUrl, template, req, doProcess)

getTaskDetailsById = (token, taskId, callback) ->

	template = "getTaskDetailsById"
	req = {
		token: token
		taskId: taskId
	}

	doProcess = (err, response, body) ->
		doc = getBody(body)
		data = doc.children[0]
		if data.name is "task"
			task = data
			callback(null, task)
		else callback({
				msg: "Bad token."
			}, null)

	request(taskQueryServiceUrl, template, req, doProcess)


### Module Export ###

humantask.findNode = findNode
humantask.authenticate = authenticate
humantask.getTasks = getTasks
humantask.getTaskDetailsById = getTaskDetailsById

module.exports = humantask

