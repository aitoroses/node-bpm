ApiManager = require "./ApiManager"
utils = require "../utils/ApiUtils"
log   = require "../utils/ApiLogger"

# API Engine Class
#
class ApiEngine
	
	# Path names
	#
	@API_DIR: "api"

	# Initialized API's
	#
	_apis: {}

	###
	# Construct a new ApiEngine
	# 
	###
	constructor: ->

		_initApi = (apiName, callback) =>
			# If the path it's a directory then it's an API
			if utils.isDirectory(ApiEngine.API_DIR + "/" + apiName)
				# Instantiate
				api = new ApiManager(apiName)
				@_apis[apiName] = api
				callback(null, api)


		utils.forEachFileInDir(ApiEngine.API_DIR, _initApi, null)

	###
	# Retrieve an API
	# 
	# @param {String} apiName, name of the API
	#
	# @return {ApiManager}, returns a named API
	#
	###
	getAPI: (apiName) ->
		@_apis[apiName]


	###
	# Get all the API's
	#
	# @return {Array<ApiManager>}, Array of API's
	#
	###
	getAllAPI: () ->
		return @_apis


module.exports = ApiEngine