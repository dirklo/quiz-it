class SessionsController < ApplicationController

    get '/login' do
        erb :"sessions/login"
    end

    get '/logout' do
        logout!
        redirect '/' 
    end

    post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            login(user)
            redirect "/users/#{current_user.id}"
        else
            flash[:message] = "Incorrect Email or Password"
            redirect '/login'
        end
    end
end