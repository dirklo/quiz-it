class Category < ActiveRecord::Base
    has_many :quizzes

    ##### CREATE SLUG FROM CATEGORY OBJECT#####
    def slug
        name.chomp.downcase.split('').reject{|l| l.match(/[^\p{L}\d\s]/u)}.join.gsub(" ", "-")
    end

    ##### FIND CATEGORY BY SLUG #####
    def self.find_by_slug(category_slug)
        Category.all.detect{|category| category.slug == category_slug}
    end

    ##### LIST THIS CATEGORIES PUBLIC QUIZZES #####
    def public_quizzes
        quizzes.find_all{|quiz| quiz.public == true }
    end
end