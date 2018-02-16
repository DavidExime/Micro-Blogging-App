require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do 
	@blogs = Blog.all
erb :home	
end

get '/users/:id' do
	@user = User.find(params[:id])
	erb :'users/profile'
end

get '/edit' do
	@user = User.find(params[:id])
	erb :'users/edit' 

end 

get '/login' do
	@user = User.find(params[:id])
	erb :'users/login'
end


get '/signup' do
	@user = User.find(params[:id])
	erb :'users/signup'

end











