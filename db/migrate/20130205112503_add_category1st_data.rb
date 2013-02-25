class AddCategory1stData < ActiveRecord::Migration
  def up
  	Category1st.create!(:category_encoding => '81', :category_name => I18n.t('Electrical Materials', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_81', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '82', :category_name => I18n.t('Custom Parts', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_82', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '83', :category_name => I18n.t('Package', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_83', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '84', :category_name => I18n.t('Fastener', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_84', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '85', :category_name => I18n.t('Structural Parts', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_85', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '86', :category_name => I18n.t('Charger and Accessories', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_86', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '87', :category_name => I18n.t('Reserve 1', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_87', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '88', :category_name => I18n.t('Reserve 2', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_88', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
    Category1st.create!(:category_encoding => '89', :category_name => I18n.t('Temporary Parts', :scope => 'category_1st_name'), :category_comment => I18n.t('level_1st_comment_89', :scope=>'category_1st_comment'), :updated_by_email => AdminUser.where(:role => "SUPER_ADMIN").first.email)
  end

  def down
    #Category1st.where(:category_encoding => '81').first.destroy
  end
end
