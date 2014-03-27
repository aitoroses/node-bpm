Interfake = require "interfake"
interfake = new Interfake()

interfake.get('/authenticate').status(200).body require("./apis/authenticate")

interfake.get('/humantask').status(200).body require("./apis/humantask")

interfake.get('/humantask/c6daab1e-9a49-46fe-b4fd-27617d8cd2f1').status(200).body require("./apis/humantask_id")

interfake.listen(3100);