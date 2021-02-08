class UsersAccessesController < ApplicationController
    delete '/accesses/:id' do
        access = UserAccess.find(params[:id])
        @quiz = access.quiz
        access.destroy
        flash[:message] = "Successfully removed access."
        @access = @quiz.user_accesses
        redirect "/quizzes/#{@quiz.id}/access"
    end
end