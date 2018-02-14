require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do 
	@blogs = Blog.all
erb :home	
end









