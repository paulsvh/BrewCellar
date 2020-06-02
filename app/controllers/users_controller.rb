class UsersController < ApplicationController
    enable :sessions

    get '/users/:id' do
        if logged_in?
            redirect '/'
        else
            flash[:error] = "Please log in."
            redirect '/login'
        end
        @user = User.find(params[:id])
        if @user && @user == @current_user
            erb :'/users/show_cellar'
        else
            redirect to '/'
        end
    end

    get '/signup' do
        if !logged_in?
            erb :'users/create_user'
        else
            flash[:error] = "You're already logged in!"
            redirect to '/'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            flash[:error] = "You must create a username, an email and a password to continue."
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
            flash[:error] = "You're already logged in!"
            redirect to '/'
        end
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/'
        else
            flash[:error] = "No account with that username and password was found, please sign up!"
            redirect to '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            flash[:error] = "You have been logged out."
            redirect to '/login'
        else
            flash[:error] = "You are not logged in."
            redirect to '/'
        end
    end

end