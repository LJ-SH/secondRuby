class AddDataToComponentCategories < ActiveRecord::Migration
  def change
  	ComponentCategory.create!(:name => 'level1-a', :updated_by_email => "super_admin@example.com");
  	ComponentCategory.create!(:name => 'level1-b', :updated_by_email => "super_admin@example.com");
  	ComponentCategory.create!(:name => 'level1-c', :updated_by_email => "super_admin@example.com");

  	ComponentCategory.create!(:name => 'level2-a-01', :updated_by_email => "super_admin@example.com", :parent => ComponentCategory.where(:name => 'level1-a').first);
  	ComponentCategory.create!(:name => 'level2-b-01', :updated_by_email => "super_admin@example.com", :parent => ComponentCategory.where(:name => 'level1-b').first);
  	ComponentCategory.create!(:name => 'level2-c-01', :updated_by_email => "super_admin@example.com", :parent => ComponentCategory.where(:name => 'level1-c').first);

  	ComponentCategory.create!(:name => 'level3-a-01-01', :updated_by_email => "super_admin@example.com", :parent =>  ComponentCategory.where(:name => 'level2-a-01').first);
  	ComponentCategory.create!(:name => 'level3-a-01-01-01', :updated_by_email => "super_admin@example.com", :parent => ComponentCategory.where(:name => 'level3-a-01-01').first);
  end
end
