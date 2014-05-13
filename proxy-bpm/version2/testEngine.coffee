ApiEngine = require "./engine/core/ApiEngine"
utils   = require "./engine/utils/ApiUtils"
logger = require "./engine/utils/ApiLogger"

engine = new ApiEngine();

authentication = engine.getAPI("authenticate")

auth = authentication.getOperation("AuthenticateOperation")

console.log(auth)


