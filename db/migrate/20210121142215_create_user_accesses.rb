class CreateUserAccesses < ActiveRecord::Migration
  def change
    create_table :user_accesses do |t|
      t.integer :user_id
      t.integer :quiz_id
      t.boolean :admin
    end 
  end
end
