require 'redis'
require 'json'
require './job'

$r = Redis.new

:task
:url

def addJob job
	$r.rpush('jobsUnDo', job.toJson)
end

# job1 = Job.new('GET', 'http://www.estcequonmetenprodaujourdhui.info')
# addJob job1
# job2 = Job.new('GET', 'http://www.joueurdugrenier.fr')
# addJob job2
# job3 = Job.new('GET', 'http://ecampusbordeaux.epsi.fr')
# addJob job3
job4 = Job.new('GET', 'http://www.journaldugeek.com/')
addJob job4

#$r.del('jobsUnDo')
#$r.del('jobsDone')