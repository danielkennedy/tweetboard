require 'sinatra'
require 'sinatra/activerecord'
require 'rack/parser'

db = URI.parse('postgres://tweetboard:tweetboard@localhost/tweetboard')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Report < ActiveRecord::Base
end

class Tweet < ActiveRecord::Base
end

class Setting < ActiveRecord::Base
end

def generate_report
  # Hit the alchemy API on an hourly basis
  # Pick top 40 (by reach) tweets
  # Get sentiment score for each one
  # Save a new row in the reports table with:
  # - the top/bottom 3 tweets
  # - score
  # - timestamp
  # Nuke the tweets caching table
end

use Rack::Parser, :content_types => {
  'application/json'  => Proc.new { |body| ::MultiJson.decode body }
}

# Debugging output middleware
before do
  puts '[Params]'
  p params
end

get "/" do
  # If we have settings, load the reports view
  # If we don't have settings, load the settings view
  @tweets = Tweet.order("created_at DESC")
  @settings = Setting.order("created_at DESC")
  @reports = Report.order("created_at DESC")
  #redirect "/new" if @notes.empty?
  erb :index
end

# ROUTES:
# POST /settings (browser set twitter/alchemy creds and search string)
# GET /settings (bot get info it needs)
# POST /tweet (bot post a new tweet)
# GET /report (browser get current score or, optionally, historical ones)

post "/settings" do
  # Should have 
  @settings = Setting.new(params)
  @settings.save
  #if @note.save
    #redirect "note/#{@note.id}"
  #else
    #erb :new
  #end
  content_type :json
  params.to_json
end

get "/settings" do
  @settings = Setting.order("created_at DESC")
  content_type :json
  @settings.to_json
end

get "/settings/:id" do
  @setting = Setting.find_by(id: params[:id])
  content_type :json
  @setting.to_json
end

post "/tweet" do
  @tweets = Setting.new(params)
  @tweets.save
end

get "/reports" do
  # FIXME: Allow query params for searching
  # List of available reports by ID
  @reports = Report.order("created_at DESC")
  content_type :json
  @reports.to_json
end

get %r{/reports/([\d]+)} do |id|
  # Specific report by ID
  puts 'get reports by id'
  @report = Report.find_by(id: id)
  content_type :json
  @report.to_json
end

get "/reports/current" do
  # Send the latest report of:
  # - top 40 (by reach) tweets' aggregate sentiment score
  # - list of top 3 positive tweets
  # - list of top 3 negative tweets
  # - percentage change since previous report
  # - trending change over last n reports
  # - timestamp for this report
  # - timestamp of previous report
end

