require 'redis'
require 'json'
require 'mechanize'

$r = Redis.new

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

def getJobsUndo
	job = JSON.parse $r.lpop('jobsUnDo')
	job = Job.new(job['task'], job['url'])
	doJob job
end

def doJob job
	puts "#{job.task} sur #{job.url}"
	result = Mechanize.new.get(job.url).title
	puts "Resultat : #{result}"
	$r.rpush('jobsDone', job.toJson)
end

getJobsUndo

jobsUndoCount = $r.llen 'jobsUnDo'
jobsDoneCount = $r.llen 'jobsDone'

puts "Jobs non traités #{jobsUndoCount} :"
puts $r.lrange('jobsUnDo', 0, -1)

puts "Jobs traités #{jobsDoneCount} :"
puts $r.lrange('jobsDone', 0, -1)