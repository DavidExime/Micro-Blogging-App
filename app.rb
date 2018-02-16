

require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'sinatra/flash'
require 'pry'

enable :sessions
set :database, "sqlite3:main.sqlite3"
set :sessions, true

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
	@user = User.find(params[:id])
	erb :'users/login'
end


get '/signup' do
	@user = User.find(params[:id])
	erb :'users/signup'

# Doris
post '/signin' do
	@username = params[:username]
	@password = params[:password]
	if user = User.where(username: @username, password: @password).first
	session[:user_id] = user.id
	# here for interpolation you always need to use double quotes
	redirect "/create-new-blog"
	else
		redirect '/'
	end	
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
    p blog
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

get '/users-:id' do
@user = User.find(params[:id])
erb :'users/profile'
end







