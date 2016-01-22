     
require 'sinatra'
require 'pg'

#for before deploy - only load these during dev mode
configure :development do |c|
  require 'pry'
  require 'sinatra/reloader'
  c.also_reload './models/*'
end 

require './db_config'
require './models/dish'
require './models/dish_type'
require './models/user'
require './models/like'

# %w{dish dish_type user}.each do |file|
#   require "./models #{file}"
# end 

enable :sessions

helpers do 
  def logged_in?
    !!current_user
     #LONG VERSION
    #   if current_user
    #     return true
    #   else
    #     return false
  end 

  def current_user
    User.find_by(id: session[:user_id])
  end 
end

def run_sql(sql)
  db = PG.connect(dbname: 'goodfoodhunting')
  results = db.exec(sql)
  db.close
  return results  
end


get '/' do
  @dish_types = DishType.all

  if params[:dish_type_id]
    @dishes = Dish.where(dish_type_id: params[:dish_type_id] )
  else
    @dishes = Dish.all

  end 

    erb :index 
end

get '/dish_types' do
  @dish_types = DishType.all

end


# show the new dish form
get '/dishes/new' do
  @dish = Dish.new
  erb :new
end


# create a dish
post '/dishes' do
  @dish = Dish.new
  @dish.name = params[:name]
  @dish.image_url = params[:image_url]
  @dish.dish_type_id = params[:dish_type_id]
  #if dish save, go to home. If not stay
  if @dish.save
    redirect to '/'
  else
    @dish_types = DishType.all
    erb :new
  end 
end


# show single dish
get '/dishes/:id' do
  @dish = Dish.find(params[:id])
  erb :show
end


# get the update form
get '/dishes/:id/edit' do
  sql = 'SELECT * FROM dish_types;'
  @dish_types = run_sql(sql)
  @dish = Dish.find(params[:id])
  erb :edit
end


# update the dish
put '/dishes/:id' do
  # update existing dish
  @dish = Dish.find(params[:id])
  @dish.name = params[:name]
  @dish.image_url = params[:image_url]
  @dish.dish_type_id = params[:dish_type_id]
  @dish.save
  # redirect to another page with a get request
  redirect to "/dishes/#{ params[:id] }"
end


#delete a dish
delete '/dishes/:id' do
  @dish = Dish.find(params[:id])
  @dish.destroy
  #can also do 'delete - different'
  # redirect to home
  redirect to '/'
end

#================= LIKE
post '/like/:id' do
  #params [:dish_id]
  #current_user.id

  like = Like.new
  like.user_id = current_user.id
  like.dish_id = params[:id]
  if like.save
      redirect to '/'
  end 

  # @dish = Dish.find(params[:id])
  # # @test = Like.find(dish_id: @dish.id, user_id: session[:user_id])
  # # if test != nil
  # #   @test.destroy
  # # else 
  #   @like = Like.new
  #   #can also do Like.create((user_id: current_user.id, dish_id: params[:dish_id]))
  #   @like.user_id = session[:user_id]
  #   @like.dish_id = @dish.id
  #   @like.save
  #   redirect to '/'
  # end
end 

delete '/likes' do
  likes = Like.where(user_id: current_user.id, dish_id: params[:dish_id])
  likes.each do |like|
    like.destroy
  end 
  redirect to '/'
end

#===============================AUTHENTICATION
#show the login form
get '/session/new' do
  erb :login
end 


#login
post '/session' do
  'logging in'
  #1 - search for the user
  user = User.find_by(email: params[:email])
  #user = User.where:email: paramas[:email]

  #2 - authenticate password
  if user && user.authenticate(params[:password])
    #3 - create a session - enable Sessions up the top - sinatra feature
    # - 'session[:user_id] is new variable'
    session[:user_id] = user.id
    
    #4 - redirect to somewhere else
    redirect to '/'

  else
    #stay at login form for now
    erb :login
  end 
end 


#logout
delete '/session' do
  session[:user_id] = nil
  redirect to '/session/new'
end 













