class TodosController < ApplicationController

  get '/activities' do
    erb :'/todos/index'
  end

  get '/activities/:id' do
    @activity = Todo.find(params[:id])
    erb :'/todos/show'
  end

  get '/activities/add/:id' do
    if logged_in?
      @user = current_user
      @activity = Todo.find(params[:id])
      Wishlist.create(:user_id => current_user.id, :todo_id => activity.id)
      erb :'/todos/addwishlist'
    else
      redirect to '/login'
    end
  end

end
