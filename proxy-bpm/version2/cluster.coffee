cluster = require('cluster');
ApiServer = require "./engine/core/ApiServer"


if cluster.isMaster

    cpuCount = require('os').cpus().length;

    for i in [0...cpuCount]
        console.log cpuCount
        cluster.fork()

else

    server = new ApiServer("soa-server:7003");
    server.http.get("/", (req, res)-> res.end("Hello World"))
    server.listen(9000)

    
cluster.on 'exit', (worker) ->

    console.log('Worker ' + worker.id + ' died :(')
    cluster.fork()