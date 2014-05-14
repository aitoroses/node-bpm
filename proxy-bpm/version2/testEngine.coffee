ApiEngine = require "./engine/core/ApiEngine"
logger = require "./engine/utils/ApiLogger"


engine = new ApiEngine();

authentication = engine.getAPI("authenticate")

auth = authentication.getOperation("AuthenticateOperation")

console.log(auth)


