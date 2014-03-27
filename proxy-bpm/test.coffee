humantask = require "./lib/humantask"

findNode = humantask.findNode

humantask.authenticate "jcooper", "welcome1", (err, result) ->

	if (err)
		console.log(err)
	else 
		# Once we are logged

		token = result.token 

		humantask.getTasks token, (err, tasks) ->

			if err
				console.log(err)
			else
				#console.log(tasks)

				for task in tasks

					taskId = findNode "taskId", task
					title = findNode "title", task

					if title?
						console.log("#{title.val} ----> taskId = #{taskId.val}")

				task = tasks[0]
				taskId = (findNode "taskId", task).val

				humantask.getTaskDetailsById token,taskId, (err, taskDetails) ->

					console.log(taskDetails)
