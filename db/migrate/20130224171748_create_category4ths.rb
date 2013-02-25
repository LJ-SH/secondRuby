class CreateCategory4ths < ActiveRecord::Migration
  def change
    create_table :category4ths do |t|
      t.string   :category_encoding
      t.string   :category_name
      t.string   :category_comment
      t.string   :updated_by_email    
      t.references  :category3rd

      t.timestamps
    end
    add_index :category4ths, :category3rd_id
  end
end
