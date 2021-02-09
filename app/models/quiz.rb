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

    def self.create_test(params)
        quiz = Quiz.new(
            name: params[:quiz][:name], 
            description: params[:quiz][:description], 
            category: Category.find(params[:quiz][:category])
        )
        params[:questions].each_with_index do |question, index|
            question = quiz.questions.new(
                content: question[:content],
                kind: question[:kind],
                order: index + 1,
                limit: question[:limit]
            )
            params[:questions][index][:answers].each do |answer| 
                question.answers.new(
                    content: answer[:content],
                    correct: !!answer[:correct],
                    comment: answer[:comment],
                    order: answer[:order]
                )
            end
        end
        quiz
    end

    def validate_quiz 
        pass = true
        message = "none"
        if !name
            message = "Quiz must have a name."
            pass = false
        elsif !description
            message = "Quiz must have a description."
            pass = false
        elsif !category
            message = "Quiz must have a category."
            pass = false
        elsif questions.empty?
            message = "Quiz must have at least 1 question."
            pass = false 
        end
        questions.each do |question|
            correct_answer_count = question.answers.filter{|q| q.correct == true}.count
            incorrect_answer_count = question.answers.filter{|q| q.correct == false}.count
            if !question.kind
                message = "All questions must have a type."
                pass = false
            elsif !question.limit
                message = "All questions must have a limit."
                pass = false
            elsif incorrect_answer_count < 1
                message = "All questions must have at least 1 incorrect answer."
                pass = false
            elsif question.kind == "mc_one" && correct_answer_count < 1 
                message = "All questions must have at least 1 correct answer."
                pass = false
            elsif question.kind == "mc_many" && correct_answer_count < 2
                message = "Questions with many correct answers must have at least 2 correct answers."
                pass = false
            end
            question.answers.each do |answer| 
                if !answer.content
                    message = "All answers must have text."
                    pass = false
                end
            end
        end
        [pass, message]
    end
end 