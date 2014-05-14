ApiServer = require "./engine/core/ApiServer"

server = new ApiServer("soa-server:7003");

server.listen(9000)

