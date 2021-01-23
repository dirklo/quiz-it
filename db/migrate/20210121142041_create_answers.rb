class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :correct
      t.integer :order
      t.integer :question_id
    end
  end
end
