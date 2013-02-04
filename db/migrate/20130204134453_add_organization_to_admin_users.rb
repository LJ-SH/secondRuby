class AddOrganizationToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :organization, :string, :default => :other

  end
end
