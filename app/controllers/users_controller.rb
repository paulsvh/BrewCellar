class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show_cellar'
    end

    get '/signup' do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/brews'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.new(username: params[:username]), email: params[:email], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/brews'
        end
    end







end