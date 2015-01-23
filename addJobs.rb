require 'redis'
require 'json'
require './job'

$r = Redis.new

def addJob job
	$r.rpush('jobsUnDo', job.toJson)
end

3.times {
	job4 = Job.new('GET', 'http://www.journaldugeek.com/')
	addJob job4
}

#$r.del('jobsUnDo')
#$r.del('jobsDone')