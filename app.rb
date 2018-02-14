require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:main.sqlite3"
set :sessions, true
require './models'


# here you render the login page which is the signin page
get '/' do   

erb :login	
end

# here you signin - you compare if the lname 
# exists in the database; if it exists you redirect to 
# profile which renders index.erb
# if not, you stay on the same page

post '/login' do 
user = User.where(fname: params[:fname]).first
	if user.lname == params[:lname]
		session[:user_id] = user.id
		redirect '/profile'
	else 
		redirect '/'
	end
end

# here you render the index.erb page; you use @user 
# to print the current suer on the index.erb page
get '/profile' do
	@user = User.find(session[:user_id]) 
erb :index
end

# here you render the edit form; we pass the :id dynamically
 # with the :id notation; in this way the edit form will render for all users that you create
get '/users/:id/edit' do
@user = User.find(params[:id])
erb :edit
end

# this method updates the current user - it is very similar to create; you have to find current user though
post '/update' do
@user = User.find(session[:user_id]) 
@user.update(fname: params[:fname], lname: params[:lname], age: params[:age])
redirect '/'
end


# this method destroys current user
post '/destroy_user' do 
	@user = User.find(session[:user_id]) 
	@user.destroy
	redirect '/'
end



























