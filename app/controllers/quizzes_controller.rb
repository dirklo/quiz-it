class QuizzesController < ApplicationController
    get '/quizzes' do
        erb :"quizzes/index"
    end

    get '/quizzes/new' do
        if !logged_in? 
            redirect "/login"
        else
            erb :"quizzes/new"
        end
    end

    get '/quizzes/history' do
        @user = User.find_by(email: session[:email])
        erb :"quizzes/history"
    end

    get '/quizzes/:id' do
        @quiz = Quiz.find(params[:id])
        @email = session[:email]
        if @quiz.is_admin?(@email) || @quiz.is_author?(@email) || @quiz.has_access?(@email)
            erb :"quizzes/show"
        else
            redirect "/login"
        end
    end

    get '/quizzes/:id/play' do
        @quiz = Quiz.find(params[:id])
        @email = session[:email]
        @user = current_user
        @questions = @quiz.questions
        @counter = 1
        if @quiz.is_admin?(@email) || @quiz.is_author?(@email) || @quiz.has_access?(@email)
            erb :"quizzes/play"
        else
            redirect "/login"
        end
    end

    post '/quizzes/:id/play' do
        @quiz = Quiz.find(params[:id])
        @answers = params[:answers].values
        @counter = 1
        @user = current_user
        if !logged_in? 
            redirect "/login"
        else
            erb :'/quizzes/results'
        end
    end

    get '/quizzes/:id/edit' do
        @quiz = Quiz.find(params[:id])
        @email = session[:email]
        if @quiz.is_admin?(@email) || @quiz.is_author?(@email)
            erb :"quizzes/edit"
        else
            redirect "/login"
        end
    end

    
end
