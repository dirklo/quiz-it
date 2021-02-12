class SessionsController < ApplicationController
    ##### RENDER THE LOGIN PAGE #####
    get '/login' do
        erb :"sessions/login"
    end

    ##### USER LOGOUT ROUTE #####
    get '/logout' do
        logout!
        flash[:message] = "Successfully logged out."
        flash[:success] = true
        erb :'/index'
    end

    ##### SEND DATA FOR USER LOGIN #####
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