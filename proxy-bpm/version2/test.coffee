ApiManager = require "./engine/core/ApiManager"
utils   = require "./engine/utils/ApiUtils"

api = new ApiManager "authenticate"

# files = utils.readFilesFromDir "api/authenticate/templates"

# utils.getContentsOfFiles "api/authenticate/templates", (err, results) -> console.log(results)

# console.log(api)
# console.log(files)

setTimeout ->


	#console.log(api)

	console.log(api.getType("Credential"))
	template = api.getTemplate("credential")

	credential = template
		login: "comdirector15"
		password: "welcome1"
	

	console.log credential


, 1000
