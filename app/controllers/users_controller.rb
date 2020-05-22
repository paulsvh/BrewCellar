class UsersController < ApplicationController

    get '/users/:id' do
        if logged_in?
            redirect '/'
        else
            redirect '/login'
        end
        @user = User.find(params[:id])
        if @user && @user == current_user
            erb :'/users/show_cellar'
        else
            redirect to '/'
        end
    end

    get '/signup' do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end

end