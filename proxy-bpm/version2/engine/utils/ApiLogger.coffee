colors = require "colors"

# Class for logging events into console
class ApiLogger

	# Debug for headers
	# @param [String] message, message to debug
	@header: (message) ->
		console.log( ("# " + message.underline).bold.red)

	# Debug for normal messages
	# @param [String] message, message to debug
	@log: (message) ->
		console.log( ("  # " + message).green.bold)

	# Log irrelevant messages
	# @param [String] message, message to debug
	@irrelevant: (message) ->
		console.log( ("   # " + message).grey.bold)

	# Debug for debugging
	# @param [String] debugging, what is being debugged
	# @param [String] message, message to debug
	@debug: (debugging, message) ->
		console.log("")
		console.log("------------------------- Debug: #{debugging} --------------------------".inverse.bold.yellow)
		console.log(message.grey.bold)
		console.log("----------------------- End debug: #{debugging} -------------------------".inverse.bold.yellow)
		console.log("")

	# Make a cutting edge in the console
	# @method
	# @static
	@cut: ->
		console.log("")
		console.log("------------------------------------------------------".grey)
		console.log("")



module.exports = ApiLogger

