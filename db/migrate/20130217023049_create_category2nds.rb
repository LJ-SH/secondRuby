class CreateCategory2nds < ActiveRecord::Migration
  def self.up
    create_table :category2nds do |t|
      t.string   :category_encoding
      t.string   :category_name
      t.string   :category_comment
      t.string   :updated_by_email
      t.integer  :category1st_id

      t.timestamps
    end
  end 

  def self.down
    drop_table :category2nds
  end  
end