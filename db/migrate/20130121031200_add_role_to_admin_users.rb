class AddRoleToAdminUsers < ActiveRecord::Migration
  def self.up
  	add_column :admin_users, :role, :enum, :limit => ROLE_DEFINITION, :default => :OTHER
  	AdminUser.reset_column_information  	
  	#AdminUser.first.update_attribute :role, 'super_admin'
  	AdminUser.find(:all, :conditions => {:email => "superadmin@example.com"})[0].update_attribute :role, "SUPER_ADMIN"
  end

  def self.down
  	remove_column :admin_users, :role
  end
end

