class UsersController < ApplicationController

  get '/signup' do
      erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(username: params[:username], password: params[:password])
    @user.save
    login(@user.id)
    redirect to "/user/#{@user.id}"
  end

  get '/user/:id' do
      @user = User.find(params[:id])
      if @user.id == session[:user_id]
      erb :'/users/show_user'
    else
      redirect to "/login"
    end
  end

  get '/login' do
      erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        login(user.id)
        redirect to "/user/#{user.id}"
      else
        redirect to '/signup'
      end
  end

end
