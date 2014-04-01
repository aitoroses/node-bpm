Config = require './config'
request = require('./apiUtils').SoapRequest
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

#########################
# App Requests          #
#########################

API = (app) ->

	app.get '/authenticate' , (req, res) ->


		humantask.authenticate req.query.login, req.query.password, (err, result) ->

			if err
				console.log(err)
				res.end(JSON.stringify(err))
			else
				res.cookie('token', result.token , {maxAge: 60 * 1000 * 5})
				res.json(result)
				res.end()


	app.get '/humantask', (req, res) ->

		humantask.getTasks req.cookies.token, (err, tasks) ->

			if err
				console.log(err)
				res.end(JSON.stringify(err))
			else
				res.end(JSON.stringify(tasks))

	app.get '/humantask/:taskId', (req, res) ->

		humantask.getTaskDetailsById req.cookies.token, req.params.taskId, (err, taskDetails) ->

			if err
				console.log(err)
				res.end(JSON.stringify(err))
			else
				res.end(JSON.stringify(taskDetails))

	app.get "/logout", (req, res) ->

		res.cookie('token', null)
		res.end JSON.stringify({msg: "Logout succesfull."})


### Module Export ###

humantask.API = API
humantask.authenticate = authenticate
humantask.getTasks = getTasks
humantask.getTaskDetailsById = getTaskDetailsById

module.exports = humantask

