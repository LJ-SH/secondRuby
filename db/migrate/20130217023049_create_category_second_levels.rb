class CreateCategorySecondLevels < ActiveRecord::Migration
  def self.up
    create_table :category_second_levels do |t|
      t.string :category_encoding
      t.string  :category_name
      t.string :category_comment
      t.string :updated_by_email
      t.integer  :category_top_level_id
      t.timestamps
    end
  end 

  def self.down
    drop_table :category_second_levels
  end  
end