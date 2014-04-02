express = require('express')

Config = {}

baseUrl = "http://soa-server:7003/"

Config.baseUrl = baseUrl
Config.debug = {
	request: true
	response: true
}

Config.urls = {}

Config.init = (app) ->
	app.configure ->
		app.use express.cookieParser('my secret here')
		app.use express.json()
		app.use express.static(__dirname + '/app')
		app.use( (req, res, next) ->
			res.header("Access-Control-Allow-Origin", "*")
			res.header("Access-Control-Allow-Headers", "X-Requested-With")
			res.setHeader("Content-Type","application/json")
			next()
		)

module.exports = Config