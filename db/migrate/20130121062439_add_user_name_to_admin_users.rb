class AddUserNameToAdminUsers < ActiveRecord::Migration
  def self.up
  	add_column :admin_users, :user_name, :string
  	AdminUser.reset_column_information  	
  	AdminUser.find(:all, :conditions => {:email => "admin@example.com"})[0].update_attribute :user_name, "super_admin"
  	#AdminUser.find(:first).update_attribute :role, "super_admin"
  	add_index :admin_users, :user_name, :unique => true
  end

  def self.down
    remove_index :admin_users, :user_name
  	remove_column :admin_users, :user_name
  end  
end
