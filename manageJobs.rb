require 'redis'
require 'json'

$r = Redis.new

:task
:url

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

def addJob job
	$r.rpush('jobsUnDo', job.toJson)
end

job1 = Job.new('GET', 'http://www.estcequonmetenprodaujourdhui.info')
addJob job1

#$r.del('jobsUnDo')
#$r.del('jobsDone')