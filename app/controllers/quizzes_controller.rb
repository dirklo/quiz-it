class QuizzesController < ApplicationController

    get '/quizzes/landing' do
        if logged_in?
            @email = session[:email]
            @user = User.find_by(email: @email)
            @authored_quizzes = @user.authored_quizzes
            @accessible_quizzes = @user.accessible_quizzes
            erb :'quizzes/landing'
        else
            redirect '/login'
        end
    end

    get '/quizzes/all' do
        erb :"quizzes/all"
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

    post '/quizzes/test' do
        puts request.body.to_json
        redirect "/"
    end

    get '/quizzes/:id/show' do
        @quiz = Quiz.find(params[:id])
        @email = session[:email]
        if @quiz.is_admin?(@email) || @quiz.is_author?(@email) || @quiz.has_access?(@email)
            erb :"quizzes/show"
        else
            redirect "/login"
        end
    end

    get '/quizzes/:id/start' do
        @quiz = Quiz.find(params[:id])
        @email = session[:email]
        @questions = @quiz.questions
        @counter = 1
        if @quiz.is_admin?(@email) || @quiz.is_author?(@email) || @quiz.has_access?(@email)
            erb :"quizzes/start"
        else
            redirect "/login"
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

    post '/quizzes/:id/results' do
        session[:answers] = request.body.read.split(",,")
        if !logged_in? 
            redirect "/login"
        else
            redirect "/quizzes/#{params[:id]}/results"
        end
    end

    get '/quizzes/:id/results' do
        @answers = session[:answers]
        @counter = 1
        @quiz = Quiz.find(params[:id])
        erb :"quizzes/results"
    end
end
