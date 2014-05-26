request  = require('request')
chai = require("chai")
chai.should()
ApiServer = require("../engine/core/ApiServer")

url = "localhost:9000"
server = new ApiServer("soa-server:7003")
engine = server._engine
console.log("\n")


describe "ApiServer", ->

	it 'should instantiate an engine', ()->
		engine.should.be.a "object"

	it 'should have APIs', ->
		engine._apis.should.be.a "object"

	it 'should have operations', ->
		for api,object of engine._apis._operations
			object.should.be.a "object"

		
describe "API descriptions", ->
	
	for k,api of engine._apis
		it "#{k} should have _operations", ->
			api._operations.should.be.a "array"
			api._operations.length.should.exist

describe "API operation", ->

	for k,api of engine._apis
		for operation in api._operations
			# Run tests for each operation
			op = new operation.content()
			opName = operation.id

			testOperation = (operation) ->
				args = operation.test.args
				expectations = operation.test.expect
				method = (operation.constructor.method || "get").toLowerCase()
				uri = "http://#{url}/#{api.name}/#{opName}"
				
				describe "#{opName}", ->
					for k,v of expectations
						
						it "#{k}", (done) ->

							#Make a request using the arguments
							request({
								uri: uri
								method: method
								qs: args
							}, (err, response,body) ->
								((body,done) ->
									v(JSON.parse(body))
									done()
								)(body, done)
							)

			if op.test? then testOperation(op)

