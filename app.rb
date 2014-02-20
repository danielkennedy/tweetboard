require 'sinatra'
require 'sinatra/activerecord'

db = URI.parse('postgres://tweetboard:tweetboard@localhost/tweetboard')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Note < ActiveRecord::Base
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

get "/" do
  @notes = Note.order("created_at DESC")
  redirect "/new" if @notes.empty?
  erb :index
end

# ROUTES:
# POST /settings (browser set twitter/alchemy creds and search string)
# GET /settings (bot get info it needs)
# POST /tweet (bot post a new tweet)
# GET /report (browser get current score or, optionally, historical ones)

post "/settings" do
  @note = Note.new(params[:note])
  if @note.save
    redirect "note/#{@note.id}"
  else
    erb :new
  end
end

get "/settings" do
end

post "/tweet" do
end

get "/reports" do
  # FIXME: Allow query params for searching
  # List of available reports by ID
end

get "/reports/:id" do # FIXME: use a regex to make sure this is a number, so it doesn't conflict with "current"
  # Specific report by ID
  @note = Note.find_by_id(params[:id])
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
