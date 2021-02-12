class Question < ActiveRecord::Base
    belongs_to :quiz
    has_many :answers


    ##### QUIZ TAKING HELPERS #####
    def get_correct_answers
        Question.find(self.id).answers.where(correct: true).to_a
    end

    def get_incorrect_answers
        Question.find(self.id).answers.where(correct: false).to_a
    end

    ##### TAKES IN NUMBER OF CORRRECT AND INCORRECT ANSWERS REQUESTED #####
    ##### SHUFFLES THEM, AND RETURNS ARRAY#####
    def shuffle_a_correct_and_b_incorrect(a = 1, b = 3)
        correct = get_correct_answers
        incorrect = get_incorrect_answers
        while correct.length > a
            correct = correct.shuffle if correct.length > 1
            correct.pop 
        end
        while incorrect.length > b
            incorrect = incorrect.shuffle if incorrect.length > 1
            incorrect.pop
        end
        (correct + incorrect).shuffle
    end
end