var fs = require("fs");
var ncp = require("ncp").ncp
ncp.limit = 16;

module.exports = function(apiname) {
	var source = __dirname + "/api"
	var destination = __dirname + "/../../api/" + apiname

	// console.log(source)
	// console.log(destination)

	fs.mkdir(destination, function(err) {
		if (err) {
			if (err.code == "EEXIST") {return console.log("API already exists.")}
			return console.error(err);
		}
		ncp(source, destination, function(err) {
			if (err) {
				return console.error(err);
			}
		 	console.log('Done!');
		});
	});
	
}