utils = require "../utils/ApiUtils"
log   = require "../utils/ApiLogger"
_     = require "lodash"


###
# Class for loading API's and their messages, operations, types...
#
###
class ApiManager

	# Path names
	#
	@API_DIR: "api"
	@CONFIG_PATH: "config"
	@TEMPLATE_DIR: "templates"
	@TYPES_DIR: "types"
	@MESSAGES_DIR: "messages"
	@OPERATIONS_DIR: "operations"


	# - {Array<Object>[:id, :content]}
	#
	_templates:  []

	# - {Array<Object>[:id, :content]}
	#
	_types:      []
	# - {Array<Object>[:id, :content]}
	#
	_messages:   []

	# - {Array<Object>[:id, :content]}
	#
	_operations: []


	###
	# Construct a new named api and load its dependencies
	# 
	# @param {String} name, name of the api folder
	#
	###
	constructor: (@name) ->
		if not @name?
			throw Error("Not valid API name.")
		log.header("API: #{@name}".toUpperCase())

		@_parseTemplates()
		@_parseTypes()
		@_parseMessages()
		@_parseOperations()

		# load configuration
		config = require("../../#{ApiManager.API_DIR}/#{@name}/#{ApiManager.CONFIG_PATH}");
		@config = config

		log.cut()

	###
	# Get the name of the API
	#
	# @return {String}
	#
	###
	getName: (templateName) ->
		return @name


	###
	# Get a template for rendering contents
	# 
	# @param {String} templateName, name of the api folder
	#
	# @return {Object}, return a lodash template
	#
	###
	getTemplate: (templateName) ->
		if not templateName?
			throw Error("No templateName is given.")
		for tmpl in @_templates
			if tmpl.id == templateName then return _.template(tmpl.content)
		return undefined
	

	###
	# Get a type that operates with a template for rendering contents
	# 
	# @param {String} typeName, name of the api folder
	#
	# @return {Object}, return a type mapped to a template
	#
	###
	getType: (typeName) ->
		_this = @
		if not typeName?
			throw Error("No typeName is given.")
		for type in @_types
			if type.id == typeName
				# Add toXML method to the returned type
				type.content.prototype.toXML = -> 
					_this.getTemplate(type.content.TEMPLATE)(this)
				return type.content
		return undefined

	###
	# Get a soap message for sending to the BPM server
	# 
	# @param {String} messageName, name of the api folder
	#
	# @return {Object}, return a message type
	#
	###
	getMessage: (messageName) ->
		_this = @
		if not messageName?
			throw Error("No messageName is given.")
		for message in @_messages
			if message.id == messageName
				content = message.content
				# Add toXML method to the returned message
				content.prototype.toXML = -> 
					_this.getTemplate(content.TEMPLATE)(this)
				return content
		return undefined


	###
	# Get a operation to execute it
	# 
	# @param {String} messageName, name of the api folder
	#
	# @return {Object}, return a message type
	#
	###
	getOperation: (operationName) ->
		if not operationName?
			throw Error("No operationName is given.")
		for operation in @_operations
			if operation.id == operationName
				content = operation.content
				content.prototype.api = @
				return content
		return undefined


	###
	# Inner function for initialize api templates in the constructor
	#
	###
	_parseTemplates: ->
		_this = @
		utils.getContentsOfFiles "#{ApiManager.API_DIR}/#{@name}/#{ApiManager.TEMPLATE_DIR}", (err, results) ->
			_this._templates = results
			for each in results
				utils.log("template", each.id.white)


	###
	# Inner function for initialize api templates in the constructor
	#
	###
	_parseTypes: ->
		_this = @
		utils.requireFilesFromPath "#{ApiManager.API_DIR}/#{@name}/#{ApiManager.TYPES_DIR}", (err, results) ->
			_this._types = results
			for each in results
				utils.log("type",each.id.magenta)


	###
	# Inner function for initialize api messages in the constructor
	#
	###
	_parseMessages: ->
		_this = @
		utils.requireFilesFromPath "#{ApiManager.API_DIR}/#{@name}/#{ApiManager.MESSAGES_DIR}", (err, results) ->
			_this._messages = results
			for each in results
				utils.log("message",each.id.blue)


	###
	# Inner function for initialize operations in the constructor
	#
	###
	_parseOperations: ->
		_this = @
		utils.requireFilesFromPath "#{ApiManager.API_DIR}/#{@name}/#{ApiManager.OPERATIONS_DIR}", (err, results) ->
			_this._operations = results
			for each in results
				utils.log("operation",each.id.cyan)


module.exports = ApiManager
