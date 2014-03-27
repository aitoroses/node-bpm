_ = require('underscore');
coffee = require("coffee-script");

templates = {};

compileTemplate = (name) ->
	templates[name] = _.template(require("./templates/#{name}"));

compileTemplate("authenticate")


compiler = (name) ->
	template = compileTemplate(name)
	return template;


module.exports = compiler