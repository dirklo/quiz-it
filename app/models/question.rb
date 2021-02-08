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

    def shuffle_a_correct_and_b_incorrect(a = 1, b = 3)
        correct = get_correct_answers
        incorrect = get_incorrect_answers
        while correct.length > a
            correct.pop
        end
        while incorrect.length > b
            incorrect.pop
        end
        (correct + incorrect).shuffle.each_with_index{|answer, index| answer.order = index + 1}
    end

    def sort_answers_by_order
        sorted = self.answers.sort {|a, b| a.order <=> b.order}
    end
end