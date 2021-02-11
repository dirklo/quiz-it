class QuizzesController < ApplicationController
    get '/quizzes' do
        erb :"quizzes/index"
    end
    
    ##### RENDER FOR FOR NEW QUIZ #####
    get '/quizzes/new' do
        @categories = Category.all
        if !logged_in? 
            flash[:message] = "You must be logged in to create a new quiz."
            redirect "/login"
        else
            erb :"quizzes/new"
        end
    end

    ##### POST DATA FOR A NEW QUIZ #####
    post '/quizzes' do
        @test_quiz = Quiz.create_test(params)
        validated = @test_quiz.validate_quiz

        if validated[0] && logged_in?
            quiz = Quiz.new_to_database(params, current_user)
            flash[:message] = "Quiz successfully created"
            flash[:success] = true
            redirect "/quizzes/#{quiz.id}"
        else
            @categories = Category.all
            flash[:message] = validated[1]
            erb :'/quizzes/newedit'
        end
    end
    
    ##### VIEW QUIZ HISTORY #####
    get '/quizzes/history' do
        if logged_in? 
            erb :"quizzes/history"
        else
            flash[:message] = "You must be logged in to view your hisory."
            redirect "/login"
        end 
    end

    ##### RENDER QUIZ SHOW PAGE #####
    get '/quizzes/:id' do
        @quiz = Quiz.find(params[:id])
        if logged_in?
            if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email) || @quiz.has_access?(current_user.email) || @quiz.public == true
                erb :"quizzes/show"
            else
                flash[:message] = "You do not have access to this quiz."
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:message] = "You must be logged in to continue"
            redirect "/login"
        end
    end

    ##### SEND DATA FOR QUIZ EDIT #####
    patch '/quizzes/:id' do
        @test_quiz = Quiz.create_test(params)
        validated = @test_quiz.validate_quiz

        if logged_in?
            if validated[0]
                quiz = Quiz.find(params[:id])
                if quiz.is_admin?(current_user.email) || quiz.is_author?(current_user.email)
                    quiz = Quiz.update_to_database(params, quiz)
                    flash[:message] = "Quiz succcessfully Updated"
                    flash[:success] = true
                    redirect "/quizzes/#{quiz.id}"
                else
                    flash[:message] = "You must be an administrator on this quiz to continue."
                    redirect "/users/#{current_user.id}"  
                end
            else
                @quiz = Quiz.find(params[:id])
                @categories = Category.all
                flash[:message] = validated[1]
                erb :'/quizzes/editedit'
            end
        else    
            flash[:message] = "You must be logged in to continue."
            redirect "/login"   
        end
    end

    ##### DELETE A QUIZ #####
    delete '/quizzes/:id' do
        if logged_in?
            quiz = Quiz.find(params[:id])
            if quiz.is_author?(current_user.email)
                quiz.questions.each do |question|
                    question.answers.destroy_all
                end
                quiz.questions.destroy_all
                quiz.results.destroy_all
                quiz.user_accesses.destroy_all
                quiz.delete
                flash[:message] = "Quiz successfully deleted."
                flash[:success] = true
                redirect "/users/#{current_user.id}"  
            else
                flash[:message] = "Only the author of a quiz may delete."
                redirect "/users/#{current_user.id}" 
            end
        else    
            flash[:message] = "You must be logged in to continue."
            redirect "/login"  
        end    
    end

    ##### TAKE A QUIZ #####
    get '/quizzes/:id/play' do
        if logged_in?
            @quiz = Quiz.find(params[:id])
            @question_hashes = @quiz.create_question_hashes
            if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email) || @quiz.has_access?(current_user.email) || @quiz.public == true
                erb :"quizzes/play"
            else
                flash[:message] = "You do not have access to this quiz."
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:message] = "You must be logged in to continue."
            redirect "/login"   
        end
    end

    ##### SEND DATA TO CHECK ANSWERS AND RENDER RESULTS #####
    post '/quizzes/:id/play' do
        @quiz = Quiz.find(params[:id])
        if logged_in?
            if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email) || @quiz.has_access?(current_user.email) || @quiz.public == true
                @questions = @quiz.questions
                @correct_answers = @questions.map{|q| q.get_correct_answers}
                answers = @quiz.answers
                @results = Answer.create_checked_answers(params[:answers].values, answers)
                @scores = Answer.get_scores(@results, @questions)
                @percent = Answer.get_percent(@scores)
                Result.create(user: current_user, quiz: @quiz, score: @percent, date: Time.now)
                erb :'/quizzes/results'
            else
                flash[:message] = "You do not have access to this quiz."
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:message] = "You must be logged in to continue."
            redirect "/login"
        end
    end

    ##### RENDER FORM TO EDIT A QUIZ #####
    get '/quizzes/:id/edit' do
        if logged_in?
            @quiz = Quiz.find(params[:id])
            if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email)
                @categories = Category.all
                erb :'quizzes/edit'
            else
                flash[:message] = "You are not an administrator on this quiz."
                flash[:success] = false
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:message] = "You must be logged in to continue"
            redirect '/login'
        end
    end

    ##### RENDER FORM TO EDIT ACCESS TO A QUIZ #####
    get '/quizzes/:id/access' do
        if logged_in?
            @quiz = Quiz.find(params[:id])
            if @quiz.author == current_user
                @access = @quiz.user_accesses
                if @quiz.is_author?(current_user.email)
                    erb :'quizzes/access'
                else
                    flash[:message] = "Only the quiz creator can change permissions."
                    redirect "/users/#{current_user.id}"
                end
            else
                flash[:message] = "Only the author of a quiz may change access priveleges."
                redirect "/users/#{current_user.id}"
            end
        else 
            flash[:message] = "You must be logged in to continue"
            redirect '/login'
        end
    end

    ##### SEND DATA TO CREATE NEW ACCESS #####
    post '/quizzes/:id/access' do
        if logged_in?
            quiz = Quiz.find(params[:id])
            if current_user == quiz.author
                user = User.find_by(email: params[:email])
                user_access = UserAccess.find_by(user_id: user.id, quiz_id: quiz.id) unless !user
                if !user
                    flash[:message] = "That email does not belong to a registered user."
                elsif user_access && !!user_access.admin == !!params[:admin]
                    flash[:message] = "That user already has access to this quiz"
                elsif user_access
                    flash[:message] = "Updating Admin Privelege for #{user_access.user.email}"
                    flash[:success] = true
                    user_access.admin = !!params[:admin]
                    user_access.save
                else 
                    quiz.users << user
                    user_access = UserAccess.find_by(user_id: user.id, quiz_id: quiz.id)
                    user_access.admin = !!params[:admin]
                    user_access.save
                end
                redirect "quizzes/#{quiz.id}/access"
            else
                flash[:message] = "Only the author of a quiz may change access priveleges."
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:message] = "You must be logged in to continue"
            redirect '/login'
        end
    end
    
    ##### SEND DATA TO UPDATE ACCESS TO A QUIZ #####
    patch '/quizzes/:id/access' do
        if logged_in?
            quiz = Quiz.find(params[:id])
            if current_user == quiz.author
                params[:users].each do |user|
                    this_user = User.find_by(email: user[0])
                    if user[1] == "delete"
                        UserAccess.find_by(quiz_id: quiz.id, user_id: this_user.id).destroy
                    else
                        user_access = UserAccess.find_by(quiz_id: quiz.id, user_id: this_user.id)
                        user_access.admin = user[1]
                        user_access.save
                    end
                end
                flash[:message] = "Quiz Access Saved"
                flash[:success] = true
                @access = quiz.user_accesses
                redirect "quizzes/#{quiz.id}/access"
            else
                flash[:message] = "Only the author of a quiz may change access priveleges."
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:message] = "You must be logged in to continue"
            redirect '/login'
        end
    end

    ##### RENDER QUIZ STATISTICS FOR ADMIN OR AUTHOR #####
    get '/quizzes/:id/statistics' do
        @quiz = Quiz.find(params[:id])
        if @quiz.is_admin?(current_user.email) || @quiz.is_author?(current_user.email)
            @average = Result.average_score(@quiz.results)
            erb :'quizzes/statistics'
        else
            flash[:message] = "You are not an administrator on this quiz."
            redirect "/users/#{current_user.id}"
        end
    end
end
