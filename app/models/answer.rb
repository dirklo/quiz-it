class Answer < ActiveRecord::Base
    belongs_to :question

    ##### QUIZ TAKING HELPERS #####
    def self.is_correct?(answer_id)
        find(answer_id).correct
    end

    def self.check_answers(answer_ids)
        answer_ids.map do |item|
            if item.class == String
                is_correct?(item)
            elsif item.class == Array
                item.map do |answer_id|
                    is_correct?(answer_id)
                end
            end
        end
    end

    def self.create_checked_answers(answer_arrays, answers)
        answer_arrays.map do |array|
            array.map do |answer_id|
                answer = answers.detect{|x| x.id == answer_id.to_i}
                [answer.question.content, answer.content, answer.correct]
            end
        end
    end


    ##### QUIZ CREATION HELPERS#####

end
