class CreateCategory1sts < ActiveRecord::Migration
  def self.up
    create_table :category1sts do |t|
      t.string  :category_encoding
      t.string  :category_name
      t.string  :category_comment
      t.string  :updated_by_email

      t.timestamps
    end
    add_index :category1sts, :category_encoding    
  end 

  def self.down
    drop_table :category1sts
  end
end
