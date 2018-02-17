require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'sinatra/flash'
require 'pry'

set :database, "sqlite3:main.sqlite3"
set :sessions, true


def current_user
 User.find_by_id(session[:user_id])
end

# Home page
get '/' do 
	@blogs = Blog.all
erb :home	
end

#Contributors page
get '/contributors' do 
	@users = User.all
erb :contributors	
end

# Public Blog List by Contributor
get '/contributors/:id' do
	user = User.find(params[:id])
	@blogs = Blog.where(user_id: user.id)
erb :bloglist
end

# User's Profile page
get '/users/:id' do
	@user = User.find(params[:id])
	erb :'users/profile'
end

# User Logout function
post '/logout' do
	session[:user_id] = nil
	redirect "/"
end

# User Edit page
get '/users/:id/edit' do
	@user = User.find(params[:id])
	erb :'users/edit' 
end 

# User Signup page
get "/signup" do
	erb :'users/signup'
end

# User Update function
post '/users/:id/update_user' do 
	user = User.find(params[:id])
	user.update(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password])
redirect "/users/#{user.id}"
end

# User Login page
get '/login' do
	erb :'users/login'
end

# User Login function
post '/signin' do
  @username = params[:username]
  @password = params[:password]
  if user = User.where(username: @username, password: @password).first
  	session[:user_id] = user.id
	redirect "/users/#{user.id}"
  else
  	redirect '/'
  end	
end

# User Signup function
post '/create_users' do
	newUsername = params[:username]
	if User.where(username: newUsername) == []
	   user = User.create(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password])	
	   session[:user_id] = user.id
	   redirect "/users/#{user.id}"	   
	else
		flash[:warning] = 'this username have existed'
		redirect '/signup'
	end 	
end

# Create New Blog page
get '/create_new_blog' do
	if session[:user_id] == nil
	   flash[:alert] = 'You are not signed in'
       redirect "/"
    else 
       erb :'blogs/new'  
    end	
end

# Create New Blog function
post '/create_blogs' do
    user = User.find(session[:user_id])
    blog = Blog.create(title: params[:title], content: params[:content], user_id: user.id)
	redirect "/blogs/#{blog.id}"
end	

# Blog page
get '/blogs/:id' do
	@blog = Blog.find(params[:id])
erb :'blogs/page'
end

# Personal Blog List page
get '/your_blog_list' do
	user = User.find(session[:user_id])
	@blogs = Blog.where(user_id: user.id)
erb :'blogs/list'
end

# Blog Delete function
post "/blogs/:id/delete_blog" do
	blog = Blog.find(params[:id])
	blog.destroy
    redirect '/your_blog_list'
end

# User Logout function
post '/logout' do
	session[:user_id] = nil
	redirect "/"
end

# User Delete function
post "/users/:id/delete_user" do
	user = User.find(params[:id])
	user.destroy
	redirect '/'
end




