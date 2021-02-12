class Answer < ActiveRecord::Base
    belongs_to :question

    ##### QUIZ TAKING HELPERS #####
    def self.is_correct?(answer_id)
        find(answer_id).correct
    end

    ##### CHECKS ANSWERS AND RETURNS BOOLEANS #####
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

    ##### TAKES IN ARRAYS OF RESPONSES FROM PLAY FORM, CHECKS ANSWERS AGAINST THE DB #####
    def self.create_checked_answers(answer_arrays, answers)
        answer_arrays.map do |array|
            array.map do |answer_id|
                answer = answers.detect{|x| x.id == answer_id.to_i}
                [answer.question.content, answer.content, answer.correct, answer.comment]
            end
        end
    end

    ##### TAKES IN RESULTS ARRAYS AND QUESTIONS, CALCULATES SCORE AMOUNTS #####
    def self.get_scores(results, questions)
        final = []
        questions.each_with_index do |question, index|
            if question.kind == "mc_one"
                results[index][0][2] == true ? correct = 1 : correct = 0
                final << [correct, 1]
            elsif question.kind == "mc_many"
                possible_points = question.answers.filter{|a| a.correct == true}.count
                correct_answers = results[index].each.filter{|a| a[2] == true}.count
                incorrect_answers = results[index].each.filter{|a| a[2] == false}.count
                if results[index].count <= possible_points
                    final << [correct_answers, possible_points]
                else    
                    final << [(correct_answers - incorrect_answers), possible_points]
                end
            end
        end
        final
    end

    ##### TAKES IN SCORES AND CALCULATES PERCENTAGE CORRECT #####
    def self.get_percent(scores)
        total_correct = scores.inject(0){|sum, x| sum + x[0] }
        total_possible = scores.inject(0){|sum, x| sum + x[1] }
        percent = (total_correct.to_f / total_possible.to_f) * 100
        percent.round(2)
    end
end
