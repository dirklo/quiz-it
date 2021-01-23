class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
    t.string :name
    t.date :date_created
    t.integer :author_id
    end
  end
end
