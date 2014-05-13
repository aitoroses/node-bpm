ApiManager = require "./engine/core/ApiManager"
ApiEngine = require "./engine/core/ApiEngine"
utils   = require "./engine/utils/ApiUtils"
logger = require "./engine/utils/ApiLogger"

# Instantiate a new API
authenticateAPI = new ApiManager "authenticate"

setTimeout ->

	# When all the stuff it's loaded

	# Get a credential type and the operation to do
	Credential = authenticateAPI.getType "Credential" 
	AuthenticateOperation = authenticateAPI.getOperation "AuthenticateOperation" 

	# Instantiate a new operation
	op = new AuthenticateOperation( new Credential "comdirector15", "welcome1" )
	
	# Log the Authenticate Message (using debug level)
	logger.debug( "Authenticate Message", op.message() )

	# Execute the operation (Not implemented yet, but soon :) )
	# op.execute();

, 1000

engine = new ApiEngine();

