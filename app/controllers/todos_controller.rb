class TodosController < ApplicationController


  get '/activity' do
    erb :'/todos/index'
  end

  get '/activity/new' do
    if logged_in?
      erb :'/todos/new'
    else
      redirect to "/login"
    end
  end

  get '/activity/completed' do
    if logged_in?
      erb :'todos/addcomplete'
    else
      redirect to '/login'
    end
  end

  get '/activity/:id' do
    @activity = Todo.find(params[:id])
    erb :'/todos/show'
  end

  get '/activity/add/:id' do
    if logged_in?
      @user = current_user
      @activity = Todo.find(params[:id])
      array = current_user.wishlists.map{|a| a.todo.id}
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

  post '/activity/completed' do
    id = Todo.find_by(:name => params[:todo]).id
    if logged_in?
      completed = current_user.completes.map{|a| a.todo.id}
        if !completed.include?(id)
          array = [params[:year], params[:month], params[:day]]
          date = array.join('-')
          @activity = Complete.create(:user_id => current_user.id, :todo_id => id, :date => date)
          redirect to "/user/#{current_user.id}"
        else
          @activity = Todo.find_by(:name => params[:todo])
          erb :'/todos/addfail'
        end
    else
      redirect to '/login'
    end
  end

  delete '/activity/wishlist/:id/delete' do
    if logged_in?
      if @activity = Wishlist.find_by(:user_id => current_user, :todo_id => params[:id])
        @activity.delete
        redirect to "user/#{current_user.id}"
      else
        erb :'/todos/addfail'
      end
    else
      redirect to '/login'
    end
  end

  delete '/activity/completed/:id/delete' do
    if logged_in?
      if @activity = Complete.find_by(:user_id => current_user, :todo_id => params[:id])
        @activity.delete
        redirect to "user/#{current_user.id}"
      else
        erb :'/todos/addfail'
      end
    else
      redirect to '/login'
    end
  end

  post '/activity/:id/edit' do
    if params['url'] == ""
        redirect to "/activity/#{params[:id]}/edit"
      else
        @activity = Todo.find(params[:id])
        @activity.update(:url => params['url'])
        @activity.save
        redirect to "/activity/#{@activity.id}"
      end
  end


end
