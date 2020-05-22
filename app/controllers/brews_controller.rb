class BrewsController < ApplicationController

    get '/brews' do
        if !logged_in?
            redirect to '/login'
        else
            @brews = Brew.all
            erb :'brews/brews'
        end
    end

    get '/brews/new' do
        if logged_in?
            erb :'brews/create_brew'
        else
            redirect to '/login'
        end
    end

    post '/brews' do
        if logged_in?
            if params[:brewery] == "" || params[:beer_name] == ""
                redirect to '/brews/new'
            else
                @brew = current_user.brews.build(brewery: params[:brewery], beer_name: params[:beer_name], abv: params[:abv], package_date: params[:package_date])
                if @brew.save
                    redirect to '/brews/#{@brew.id}'
                else
                    redirect to 'brews/new'
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/brews/:id' do
        if logged_in?
            @brew = Brew.find_by_id(params[:id])
            erb :'brews/show_brew'
        else
            redirect to '/login'    






end