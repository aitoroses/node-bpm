ApiServer = require "./engine/core/ApiServer"

#server = new ApiServer("localhost:8088")
server = new ApiServer("soa-server:7003");

server.listen(9000)
