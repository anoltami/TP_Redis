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

def getJobsTodo
 job = JSON.parse $r.lpop('jobsTodo')
 job = Job.new(job['task'], job['url'])
 doJob job
end

def doJob job
 puts "#{job.task} #{job.url}"
 result = Mechanize.new.get(job.url).title
 puts "Resultat : #{result}"
 $r.rpush('jobsDone', job.toJson)
end

#A decommenter pour supprimer les données 
#$r.del("jobsTodo")
#$r.del("jobsDone")

jobsTodoCount = $r.llen 'jobsTodo'

if jobsTodoCount > 0
 getJobsTodo
 jobsTodoCount -= 1
end

jobsDoneCount = $r.llen 'jobsDone'

puts "Jobs non traites #{jobsTodoCount} :"
puts $r.lrange('jobsTodo', 0, -1)

puts "Jobs traites #{jobsDoneCount} :"
puts $r.lrange('jobsDone', 0, -1)

