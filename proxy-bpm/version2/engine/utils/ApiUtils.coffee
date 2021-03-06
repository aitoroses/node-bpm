fs	  = require "fs"
async = require "async"
log   = require "../utils/ApiLogger"


# Class with util methods for API definitions
class ApiUtils

	# Method to check if some path corresponds to a directory
	# @param [String] path, the path to check
	# @return {Boolean}, is directory or not
	@isDirectory: (path) ->
		fs.lstatSync(path).isDirectory()


	# Method to retrieve the filenames of a dir
	# @param [String] path the path of the file to get filenames from
	# @return [Array<String>] an array with the filenames 
	@readFilesFromDir: (path) ->
		files = []
		_files = fs.readdirSync(path);
		for file in _files
			files.push(file)
		return files


	# Do some action for each file in folder
	# @param [String] path, the path of the file to get filenames from
	# @param [function(err, result)] operate function to do map operation
	# @param [function(err, result)] callback returns callback {Array<String>} 
	@forEachFileInDir: (path, operate, callback) ->
		files = ApiUtils.readFilesFromDir(path)
		async.map(files, operate, callback);


	# Return the string contents of a file
	# @param [String] file, name of the file to read contents from
	# @return [String], content of the file
	@getContentsOfFile: (file) ->
		fs.readFileSync(file, 'utf8')


	# Return the string contents of the file into one folder
	# @param [String] path, name of the path to read file contents from
	# @param [function] callback Returns [Array<String>] contents array of the files in the folder
	@getContentsOfFiles: (path, callback) ->
		files = @readFilesFromDir(path)
		_parseFile = (file, callback) ->
			callback(null, { 
				id: file.split(".")[0]
				content: ApiUtils.getContentsOfFile(path + '/' + file)
			})
		async.map(files, _parseFile, callback)


	# Return the required modules
	# @param [String] path, name of the path to require modules from
	# @param [function] callback Returns {Array<String>} required modules in an array
	@requireFilesFromPath: (path, callback) ->
		_files = @readFilesFromDir(path)
		files = []
		split = null
		for file in _files
			split = file.split(".coffee")
			if split[1]?
				files.push(split[0])
		_requireFile = (file, callback) ->
			loadedModule = require('../../' + path + '/' + file)			
			callback(null, {
				id: file,
				content: loadedModule
			})
		async.map(files, _requireFile, callback)


	# Log into console the object that it's getting registered
	# @param [String] id Name of the api message to print
	# @param [String] type Type of the message
	@log: (type, id) ->
		log.log("Registered #{type}: " + "#{id}".bold)


module.exports = ApiUtils