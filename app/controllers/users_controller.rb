class UsersController < ApplicationController

    get '/users/new' do
        erb :'/users/new'
    end
    
    get '/users/:id' do
        if logged_in?
            @user = User.find(current_user.id)
            @email = @user.email
            @authored_quizzes = @user.authored_quizzes
            @accessible_quizzes = @user.accessible_quizzes
            erb :'/users/show'
        else
            flash[:message] = "Please log in to continue."
            redirect '/login'
        end
    end

    post '/users' do
        if User.find_by(email: params[:user][:email])
            flash[:message] = "That email is already in use by another account."
            redirect '/users/new'
        else
            User.create(
                name: params[:user][:username], 
                email: params[:user][:email], 
                password: params[:user][:password])
            flash[:message] = "Sucessfully created user, please log in."
            redirect "/login"
        end
    end
end