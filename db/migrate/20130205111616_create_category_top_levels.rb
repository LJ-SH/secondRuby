class CreateCategoryTopLevels < ActiveRecord::Migration
  def self.up
    create_table :category_top_levels do |t|
      t.string  :category_encoding
      t.string  :category_name
      t.string  :category_comment
      t.string  :updated_by_email

      t.timestamps
    end
    add_index :category_top_levels, :category_encoding    
  end 

  def self.down
    drop_table :category_top_levels
  end
end
