class UsersController < ApplicationController

    get '/users/new' do
        erb :'/users/new'
    end
    
    get '/users/:id' do
        if logged_in?
            @email = session[:email]
            @user = User.find_by(email: @email)
            @authored_quizzes = @user.authored_quizzes
            @accessible_quizzes = @user.accessible_quizzes
            erb :'/users/show'
        else
            redirect '/login'
        end
    end

    post '/users' do
        user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
        redirect "/login"
    end
end