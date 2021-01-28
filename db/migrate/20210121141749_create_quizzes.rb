class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
    t.string :name
    t.string :description
    t.date :date_created
    t.boolean :public
    t.integer :category_id
    t.integer :author_id
    end
  end
end
