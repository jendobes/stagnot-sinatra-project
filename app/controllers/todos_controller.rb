class TodosController < ApplicationController


  get '/activities' do
    erb :'/todos/index'
  end

  get '/activities/new' do
    if logged_in?
      erb :'/todos/new'
    else
      redirect to "/login"
    end
  end

  get '/activities/completed' do
    if logged_in?
      erb :'todos/addcomplete'
    else
      redirect to '/login'
    end
  end

  get '/activities/:id' do
    @activity = Todo.find(params[:id])
    erb :'/todos/show'
  end

  get '/activities/add/:id' do
    if logged_in?
      @user = current_user
      @activity = Todo.find(params[:id])
      array = User.find(2).wishlists.map{|a| a.todo.id}
      if !array.include?(@activity.id)
      Wishlist.create(:user_id => current_user.id, :todo_id => @activity.id)
      erb :'/todos/addwishlist'
    else
      erb :'/todos/addfail'
    end
    else
      redirect to '/login'
    end
  end

  post '/activity' do
    if logged_in?
      @activity = Todo.create(name: params[:name], url: params[:url])
      @activity.save
      erb :'/todos/index'
    else
      redirect to '/login'
    end
  end



end
