ApiManager = require "./engine/core/ApiManager"
utils   = require "./engine/utils/ApiUtils"
logger = require "./engine/utils/ApiLogger"

api = new ApiManager "authenticate"

# files = utils.readFilesFromDir "api/authenticate/templates"

# utils.getContentsOfFiles "api/authenticate/templates", (err, results) -> console.log(results)

# console.log(api)
# console.log(files)

setTimeout ->

	Credential = api.getType("Credential")
	AuthenticateOperation = api.getOperation("AuthenticateOperation")

	op = new AuthenticateOperation(new Credential("comdirector15", "welcome1"))
	
	logger.debug("authenticate message" ,op.message())

, 1000

