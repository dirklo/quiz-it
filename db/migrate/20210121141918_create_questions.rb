class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.string :kind
      t.integer :order
      t.integer :limit
      t.integer :quiz_id
    end
  end
end
