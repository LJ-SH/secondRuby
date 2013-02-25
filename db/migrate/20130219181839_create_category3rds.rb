class CreateCategory3rds < ActiveRecord::Migration
  def self.up
    create_table :category3rds do |t|
      t.string   :category_encoding
      t.string   :category_name
      t.string   :category_comment
      t.string   :updated_by_email    
      t.references  :category2nd

      t.timestamps
    end
    add_index :category3rds, :category2nd_id
  end 

  def self.down
    drop_table :category3rds
  end
end
