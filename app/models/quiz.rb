class Quiz < ActiveRecord::Base
    belongs_to :author, :class_name => "User"
    belongs_to :category
    has_many :questions
    has_many :answers, through: :questions
    has_many :user_accesses
    has_many :users, through: :user_accesses
    has_many :results
    has_many :users_taken, through: :results, source: :user

    ##### QUIZ ACCESS CHECKS #####
    def has_access?(email)
        user_accesses.map{|i| i.user.email}.include?(email)
    end

    def is_admin?(email)
        user_accesses.where(admin: true).map{|i| i.user.email}.include?(email)
    end

    def is_author?(email)
        author.email == email 
    end


    ##### QUIZ TAKING HELPERS #####
    def create_question_hashes
        questions.map do |question| 
            if question.kind == "mc_one"
                num_correct = 1
            elsif question.kind == "mc_many"
                num_correct = question.get_correct_answers.length
            end
            num_incorrect = question.get_incorrect_answers.length
            question.limit = num_incorrect + num_correct if !question.limit
            shuffled = question.shuffle_a_correct_and_b_incorrect(num_correct, question.limit - num_correct)
            {question => shuffled} 
        end
    end
end 