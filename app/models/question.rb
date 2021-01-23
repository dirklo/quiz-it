class Question < ActiveRecord::Base
    belongs_to :quiz
    has_many :answers

    def get_correct_answers
        Question.find(self.id).answers.where(correct: true)
    end

end