require 'redis'
require 'json'
require 'mongo'
require 'mongoid'
require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require './job'


$r = Redis.new
$c = Mongo::Connection.new
Mongoid.database = $c['TP_Redis']

class Page
	include Mongoid::Document

	field :title			, type: String 		, default: ''
	field :url				, type: String
	field :keywords			, type: Array 		, default: ''
	field :description		, type: String		, default: ''
end

def getJobsUndo
	job = JSON.parse $r.lpop('jobsUnDo')
	job = Job.new(job['task'], job['url'])
	doJob job
end

def doJob job
	puts "#{job.task} sur #{job.url}"

	webPage = Nokogiri::HTML(open(job.url))

	title = webPage.css('title').text
	url = job.url
	keywords = webPage.css("meta[name='keywords']")[0]['content'].split(',')
	description = webPage.css("meta[name='description']")[0]['content']

	page = Page.new
	page[:title] = title
	page[:url] = url
	page[:keywords] = keywords
	page[:description] = description

	page.save
	$r.rpush('jobsDone', job.toJson)

	puts "#{title} traité"
end

getJobsUndo

jobsUndoCount = $r.llen 'jobsUnDo'
jobsDoneCount = $r.llen 'jobsDone'

puts "Jobs non traités #{jobsUndoCount} :"
puts $r.lrange('jobsUnDo', 0, -1)

puts "Jobs traités #{jobsDoneCount} :"
puts $r.lrange('jobsDone', 0, -1)