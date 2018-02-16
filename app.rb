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

get '/' do 
	@blogs = Blog.all
erb :home	
end

get '/contributors' do 
	@users = User.all
erb :contributors	
end

get '/contributors/:id' do
	user = User.find(params[:id])
	@blogs = Blog.where(user_id: user.id)
erb :bloglist
end

get '/users/:id' do
	@user = User.find(params[:id])
	erb :'users/profile'
end

#dave
post '/logout' do
session[:user_id] = nil
redirect "/"
end

#dave
get '/edit' do
	# @user = User.find(params[:id])
	erb :'users/edit' 
end 


post '/update_user' do 
	user = User.find(session[:user_id])
	User.update(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password])
redirect "/users/#{user.id}"
end

get '/login' do
	erb :'users/login'
end

#dave
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

#dave
post '/signup' do
user = User.create(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password])
	session [:user_id] = user.id
    redirect "/users/#{user.id}"
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

post "/delete_blog" do
	user = User.find(session[:user_id])
	@blogs = Blog.where(user_id: user.id)
	.destroy
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




