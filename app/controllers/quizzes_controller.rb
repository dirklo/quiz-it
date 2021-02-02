class QuizzesController < ApplicationController
    get '/quizzes' do
        erb :"quizzes/index"
    end
    
    get '/quizzes/new' do
        @categories = Category.all
        if !logged_in? 
            flash[:message] = "You must be logged in to create a new quiz."
            redirect "/login"
        else
            erb :"quizzes/new"
        end
    end

    post '/quizzes' do
        quiz = Quiz.create(
            name: params[:quiz][:name], 
            description: params[:quiz][:description], 
            category: Category.find(params[:quiz][:category]), 
            public: !!params[:quiz][:public],
            date_created: Time.now,
            author: current_user
            )
        params[:questions].each_with_index do |question, index|
            question = quiz.questions.create(
                content: question[:content],
                kind: question[:kind],
                order: index + 1,
                limit: question[:limit]
            )
            params[:questions][index][:answers].each do |answer| 
                question.answers.create(
                    content: answer[:content],
                    correct: !!answer[:correct],
                    order: answer[:order]
                )
            end
        end
        redirect "/quizzes/#{quiz.id}"
    end
    
    post '/quizzes/add' do
    end
    
    get '/quizzes/history' do
        if !logged_in? 
            flash[:message] = "You must be logged in to view your hisory."
            redirect "/login"
        else
            erb :"quizzes/history"
        end 
    end

    get '/quizzes/:id' do
        @quiz = Quiz.find(params[:id])
        if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email) || @quiz.has_access?(current_user.email)
            erb :"quizzes/show"
        else
            flash[:message] = "You do not have access to this quiz."
            redirect "/users/#{current_user.id}"
        end
    end

    get '/quizzes/:id/play' do
        @quiz = Quiz.find(params[:id])
        @question_hashes = @quiz.create_question_hashes

        if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email) || @quiz.has_access?(current_user.email)
            erb :"quizzes/play"
        else
            flash[:message] = "You do not have access to this quiz."
            redirect "/users/#{current_user.id}"
        end
    end


    post '/quizzes/:id/play' do
        @quiz = Quiz.find(params[:id])
        @questions = @quiz.questions
        answers = @quiz.answers
        @results = Answer.create_checked_answers(params[:answers].values, answers)

        if !logged_in?
            flash[:message] = "You must be logged in to continue."
            redirect "/login"
        else
            erb :'/quizzes/results'
        end
    end

    get '/quizzes/:id/edit' do
        @quiz = Quiz.find(params[:id])
        if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email)
            erb :"quizzes/edit"
        else
            flash[:message] = "You are not an administrator on this quiz."
            redirect "/users/#{current_user.id}"
        end
    end
end
