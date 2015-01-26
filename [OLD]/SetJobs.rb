require 'redis'
require 'json'

$r = Redis.new

:task
:url

$r.del("jobsTodo")

class Job
 def initialize(task,url)
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

def addJob(job)
 $r.rpush('jobsTodo', job.toJson)
end

job1 = Job.new('GET', 'http://www.google.fr')
addJob(job1)

job2 = Job.new('GET', 'http://www.journaldugeek.com')
addJob(job2)