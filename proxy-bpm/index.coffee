express = require('express')
humantaskAPI = require('./lib/humantask').API
servicesAPI = require('./lib/services').API
init = require("./lib/config").init
	

app = express()

# Configuration
init(app)

# Load Services API's
servicesAPI(app)

# Load HumanTask API's
humantaskAPI(app)

# Start listening
app.listen(3100)

