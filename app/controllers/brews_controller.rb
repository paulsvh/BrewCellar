class BrewsController < ApplicationController

    get '/brews' do
        if !logged_in?
            redirect to '/login'
        else
            @brews = Brew.all
            erb :'brews/brews'
        end
    end










end