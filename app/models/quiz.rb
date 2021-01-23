class Quiz < ActiveRecord::Base
    belongs_to :author, :class_name => "User"
    has_many :questions
    has_many :user_accesses
    has_many :users, through: :user_accesses
    has_many :results
    has_many :users_taken, through: :results, source: :user

    
    def has_access?(email)
        user_accesses.map{|i| i.user.email}.include?(email)
    end

    def is_admin?(email)
        user_accesses.where(admin: true).map{|i| i.user.email}.include?(email)
    end

    def is_author?(email)
        author.email == email 
    end
end 