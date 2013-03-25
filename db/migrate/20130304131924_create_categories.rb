class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.enum   :category_type, :limit => COMPONENT_CATEGORY_DEFINITION
      t.string :level1
      t.string :level2
      t.string :level3
      t.string :level4
      t.string  :name
      t.string  :comment
      t.string :updated_by_email      
      t.timestamps
    end
    add_index :categories, :category_type
    add_index :categories, [:level1, :level2, :level3, :level4], :unique => true
  end
end