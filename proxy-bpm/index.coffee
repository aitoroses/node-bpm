xmldoc  = require('xmldoc')
express = require('express')
humantask = require('./lib/humantask')
services = require('./lib/services')
	

app = express('app');

app.configure ->
	app.use express.cookieParser('my secret here')
	app.use express.static(__dirname + '/app')
	app.use( (req, res, next) ->
		res.header("Access-Control-Allow-Origin", "*")
		res.header("Access-Control-Allow-Headers", "X-Requested-With")
		res.setHeader("Content-Type","text/json")
		next()
	)

app.get('/form/:requestId', (req,res) ->

	# request({
	# 	method: 'POST',
	# 	uri: 'http://soa-server:7003/soa-infra/services/default/eAppServices/Service_Form_Get_ep',
	# 	headers: {"Content-Type": "text/xml"},
	# 	body: '' +
	# 			'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://xmlns.oracle.com/eApp/eAppServices/Service_Form_Get">'+
	# 			   '<soapenv:Header/>'+
	# 			  '<soapenv:Body>'+
	# 				 '<ser:formGet>'+
	# 					'<ser:requestId>' + req.params.requestId + '</ser:requestId>'+
	# 					 '<ser:currentStepId>-1</ser:currentStepId>'+
	# 				  '</ser:formGet>'+
	# 			   '</soapenv:Body>'+
	# 			'</soapenv:Envelope>'
	# }, (err, response, body) ->
	# 	if req.query.format is 'json' 
	# 		res.setHeader("Content-Type","text/json")
	# 		document = new xmldoc.XmlDocument(body);
	# 		res.end(JSON.stringify(document.children[1].children[0].children[0].children));
	# 	else
	# 		res.setHeader("Content-Type","text/xml")
	# 		res.end(body)
		
	# );

	services.service_form_get req.params.requestId, -1, (err, form) ->

		if err
			console.log(err)
			res.end JSON.stringify(err)
		else
			res.end JSON.stringify(form)

);

app.get '/authenticate' , (req, res) ->


	humantask.authenticate req.query.login, req.query.password, (err, result) ->

		if err
			console.log(err)
			res.end(JSON.stringify(err))
		else
			res.cookie('token', result.token , {maxAge: 60 * 1000 * 5})
			res.end(JSON.stringify(result))


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


app.listen(3100)

