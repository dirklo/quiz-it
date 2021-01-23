class SessionsController < ApplicationController

    get '/login' do
        erb :"sessions/login"
    end

    get '/logout' do
        logout!
        redirect '/' 
    end

    get '/signup' do
        erb :"sessions/signup"
    end

    post '/sessions' do
        login(params[:email])
        redirect '/quizzes/landing'
    end

end