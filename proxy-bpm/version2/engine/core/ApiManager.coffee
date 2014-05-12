utils = require "../utils/ApiUtils"
_     = require "lodash"

###
# Class for loading API's and their messages, operations, types...
###
class ApiManager

	@API_DIR: "../api"

	# - [ {Object}[:id, :content] ]
	_templates:  []
	_operations: []
	_messages:   []
	_types:      []


	###
	# Construct a new named api and load its dependencies
	# 
	# @param {String} name, name of the api folder
	###
	constructor: (@name) ->
		if not @name?
			throw Error("Not valid API name.")
		@_parseTemplates()
		@_parseTypes()


	###
	# Get a template for rendering contents
	# 
	# @param {String} templateName, name of the api folder
	#
	# @return {Object}, return a lodash template
	###
	getTemplate: (templateName) ->
		if not templateName?
			throw Error("No templateName is given.")
		for tmpl in @_templates
			if tmpl.id == templateName then return _.template(tmpl.content)
		return undefined
	
	###
	# Get a template for rendering contents
	# 
	# @param {String} templateName, name of the api folder
	#
	# @return {Object}, return a lodash template
	###
	getType: (typeName) ->
		if not typeName?
			throw Error("No typeName is given.")
		for type in @_types
			if type.id == typeName then return _.template(type.type)
		return undefined


	###
	# Inner function for initialize api templates in the constructor
	###
	_parseTemplates: ->
		_this = @
		utils.getContentsOfFiles "api/#{@name}/templates", (err, results) ->
			_this._templates = results
			for each in results
				utils.log("template", each.id)

	_parseTypes: ->
		_this = @
		utils.requireFilesFromPath "api/#{@name}/types", (err, results) ->
			_this._types = results
			for each in results
				utils.log("type",each.id)

module.exports = ApiManager
