class User < ActiveRecord::Base
    has_secure_password
    validates :email, presence: true
    validates :email, uniqueness: true
    has_many :authored_quizzes, :class_name => "Quiz", :foreign_key => :author_id
    has_many :questions, through: :authored_quizzes
    has_many :user_accesses
    has_many :accessible_quizzes, through: :user_accesses, :source => :quiz
    has_many :results
    has_many :taken_quizzes, through: :results, :source => :quiz
end