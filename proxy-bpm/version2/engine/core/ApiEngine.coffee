ApiManager = require "./ApiManager"
utils = require "../utils/ApiUtils"
log   = require "../utils/ApiLogger"


# This class is meant to instantiate all the defined API's
class ApiEngine
	
	# @property [String] API base folder
	@API_DIR: "api"

	# @property [String] Internal API collection reference
	_apis: {}

	# Constructs a new ApiEngine
	constructor: ->
		
		# Inner method to retrieve the API's
		_initApi = (apiName, callback) =>
			# If the path it's a directory then it's an API
			if utils.isDirectory(ApiEngine.API_DIR + "/" + apiName)
				# Instantiate the API
				api = new ApiManager(apiName)
				@_apis[apiName] = api
				callback(null, api)


		utils.forEachFileInDir(ApiEngine.API_DIR, _initApi, null)


	# Retrieve an API by it's name
	# @param [String] apiName name of the API
	# @return [ApiManager] returns a named API
	getAPI: (apiName) ->
		@_apis[apiName]


	# Retrieve all the API's
	# @return {Array<ApiManager>} Array of API's
	getAllAPI: () ->
		return @_apis


module.exports = ApiEngine