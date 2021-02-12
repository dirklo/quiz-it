class CategoriesController < ApplicationController
    ##### RENDER CATEGORIES INDEX PAGE #####
    get '/categories' do
        if logged_in?
            @categories = Category.all
            erb :'categories/index'
        else
            flash[:message] = "You must be logged in to continue."
            redirect '/login'
        end
    end

    ##### RENDER SHOW PAGE FOR CATEGORIES #####
    get '/categories/:slug' do
        if logged_in?
            @category = Category.find_by_slug(params[:slug])
            erb :'categories/show'
        else 
            flash[:message] = "You must be logged in to continue."
            redirect '/login'
        end
    end
end