class BrewsController < ApplicationController

    get '/brews' do
        if !logged_in?
            flash[:error] = "Please log in."
            redirect to '/login'
        else
            @brews = current_user.brews.all
            erb :'/brews/brews'
        end
    end

    get '/brews/new' do
        if logged_in?
            erb :'brews/create_brew'
        else
            flash[:error] = "Please log in."
            redirect to '/login'
        end
    end

    post '/brews' do
        if logged_in?
            if params[:brewery] == "" || params[:beer_name] == ""
                flash[:error] = "You must input a brewery and a beer name."
                redirect to '/brews/new'
            else
                @brew = current_user.brews.build(brewery: params[:brewery], beer_name: params[:beer_name], abv: params[:abv], package_date: params[:package_date])
                if @brew.save
                    redirect to "/brews/#{@brew.id}"
                else
                    flash[:error] = "Something went wrong, please try again."
                    redirect to 'brews/new'
                end
            end
        else
            flash[:error] = "Please log in."
            redirect to '/login'
        end
    end

    get '/brews/:id' do
        if logged_in?
            @brew = Brew.find_by_id(params[:id])
            if @brew && @brew.user == current_user
                erb :'brews/show_brew'
            else
                flash[:error] = "That beer does not exist in your cellar..."
                redirect to '/brews'
            end
        else
            flash[:error] = "Please log in."
            redirect to '/login'    
        end
    end

    get '/brews/:id/edit' do
        if logged_in?
            @brew = Brew.find_by_id(params[:id])
            if @brew && @brew.user == current_user
                erb :'/brews/edit_brew'
            else
                flash[:error] = "That beer does not exist in your cellar..."
                redirect to '/brews'
            end
        else
            flash[:error] = "Please log in."
            redirect to '/login'
        end
    end

    patch '/brews/:id' do
        if logged_in?
            if params[:brewery] == "" || params[:beer_name] == ""
                flash[:error] = "You must input a brewery and a beer name"
                redirect to "/brews/#{params[:id]}/edit"
            else
                @brew = Brew.find_by_id(params[:id])
                if @brew && @brew.user == current_user
                    if @brew.update(brewery: params[:brewery], beer_name: params[:beer_name], abv: params[:abv], package_date: params[:package_date])
                        redirect to "/brews/#{@brew.id}"
                    else
                        flash[:error] = "Something went wrong, please try again."
                        redirect to "/brews/#{@brew.id}/edit"
                    end
                else
                    flash[:error] = "That beer does not exist in your cellar..."
                    redirect to '/brews'
                end
            end
        else
            flash[:error] = "Please log in."
            redirect to '/login'
        end
    end

    delete '/brews/:id/delete' do
        if logged_in?
            @brew = Brew.find_by_id(params[:id])
            if @brew && @brew.user == current_user
                @brew.delete
            end
            redirect to '/brews'
        else
            flash[:error] = "Please log in."
            redirect to '/login'
        end
    end

end