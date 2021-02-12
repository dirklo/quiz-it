class UsersController < ApplicationController
    ##### RENDER SIGNUP PAGE #####
    get '/users/new' do
        erb :'/users/new'
    end

    ##### PATH FOR MAIN LOGO #####
    get '/users/home' do
        if logged_in?
            redirect "/users/#{current_user.id}"
        else 
            redirect '/'
        end
    end

    ##### VIEW QUIZ HISTORY #####
    get '/users/history' do
        if logged_in? 
            erb :"users/history"
        else
            flash[:message] = "You must be logged in to view your hisory."
            erb :'/sessions/login'
        end 
    end
    
    ##### VIEW MY QUIZZES HOME PAGE #####
    get '/users/:id' do
        if logged_in?
            @user = User.find(current_user.id)
            @email = @user.email
            @authored_quizzes = @user.authored_quizzes
            @accessible_quizzes = @user.accessible_quizzes
            erb :'/users/show'
        else
            flash[:message] = "Please log in to continue."
            erb :'/sessions/login'
        end 
    end

    ##### SEND DATA FOR NEW USER #####
    post '/users' do
        if User.find_by(email: params[:user][:email])
            flash[:message] = "That email is already in use by another account."
            erb :'/users/new'
        elsif User.find_by(name: params[:user][:username])
            flash[:message] = "That Username is already in use by another account."
            erb :'/users/new'
        elsif params[:user][:password] != params[:user][:confirm_password]
            flash[:message] = "Passwords must match."
            erb :'/users/new'
        else
            User.create(
                name: params[:user][:username], 
                email: params[:user][:email], 
                password: params[:user][:password])
            flash[:message] = "Sucessfully created account, please log in."
            flash[:success] = true
            erb :'/sessions/login'
        end
    end

    ##### RENDER PAGE FOR ACCOUNT SETTINGS #####
    get '/users/:id/settings' do
        erb :'/users/settings'
    end

    ##### RENDER ACCOUNT DELETE CONFIRMATION #####
    get '/users/:id/confirm' do
        erb :'/users/confirm'
    end

    ##### DELETE USER ACCOUNT #####
    delete '/users/:id' do
        if logged_in? && current_user.id == params[:id].to_i
            user = User.find(current_user.id)
            user.authored_quizzes.each do |quiz|
                quiz.questions.each do |question|
                    question.answers.destroy_all
                end
                quiz.questions.destroy_all
                quiz.results.destroy_all
                quiz.user_accesses.destroy_all
                quiz.delete
            end
            user.user_accesses.destroy_all
            user.destroy
            session.clear
            flash[:message] = "User successfully deleted."
            flash[:success] = true
            erb :'/index'
        else
            flash[:message] = "There was a problem, account not deleted."
            redirect "/users/#{current_user.id}"
        end 
    end
end