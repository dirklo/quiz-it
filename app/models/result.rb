class Result < ActiveRecord::Base
    belongs_to :user
    belongs_to :quiz

    def self.average_score(results)
        results.map{|result| result.score}.inject(0){|x, sum| x + sum}.to_f/results.length
    end
end