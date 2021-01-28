class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories |t| do
      t.string name
    end 
  end
end
