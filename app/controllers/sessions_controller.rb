class SessionsController < ApplicationController

    get '/login' do
        erb :"sessions/login"
    end

    get '/logout' do
        logout!
        redirect '/' 
    end

    post '/login' do
        login(params[:email])
        redirect "/users/#{current_user.id}"
    end
end