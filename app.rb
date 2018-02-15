require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do 
	@blogs = Blog.all
erb :home	
end

get '/users-:id' do
@user = User.find(params[:id])
erb :'users/profile'
end








