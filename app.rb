

require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'sinatra/flash'
require 'pry'

enable :sessions
set :database, "sqlite3:main.sqlite3"
set :sessions, true


def current_user
 User.find_by_id(session[:user_id])
end

get '/' do 
	@blogs = Blog.all
erb :home	
end


get '/contributors' do 
	@users = User.all
erb :contributors	
end

get '/contributors/:id' do
	@user = User.find(params[:id])
	@blogs = Blog.all(user_id: user.id)
erb :blogslist
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

	erb :'users/login'
end


get '/signup' do
	erb :'users/signup'
end


get '/create-new-blog' do
	if session[:user_id] == nil
	   flash[:alert] = 'You are not signed in'
       redirect "/"
    else 
       erb :'blogs/new'  
    end	
end

post '/create' do
    user = User.find(session[:user_id])
    blog = Blog.create(title: params[:title], content: params[:content], user_id: user.id)
	redirect "/blogs/#{blog.id}"
end	


get '/blogs/:id' do
	@blog = Blog.find(params[:id])
erb :'blogs/page'
end

get '/your-blog-list' do
	user = User.find(session[:user_id])
	@blogs = Blog.where(user_id: user.id)
erb :'blogs/list'
end

get "/:id/delete_blog" do
	blog = Blog.find(params[:id])
	blog.destroy
    redirect '/your-blog-list'
end

get '/users/:id' do
    	@user = User.find(params[:id])
erb :'users/profile'
end

post '/logout' do
session[:user_id] = nil
redirect "/"
end


