class Job
	def initialize(task, url)
		@task = task
		@url = url
	end

	def task
		@task
	end

	def url
		@url
	end

	def toJson
		{task: @task, url: @url}.to_json
	end
end