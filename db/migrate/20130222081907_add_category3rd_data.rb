class AddCategory3rdData < ActiveRecord::Migration
  def up
  	@updated_by_email = AdminUser.where(:role => "SUPER_ADMIN").first.email
  	@category1st_id = Category1st.where(:category_encoding => '81').first.id
  	@category2nd_id = Category2nd.where(:category_encoding => '01', :category1st_id => @category1st_id).first.id
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '01', :category_name => I18n.t('Chip Resistors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '02', :category_name => I18n.t('Varistors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '03', :category_name => I18n.t('Thermistors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '04', :category_name => I18n.t('Pumping Resistors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '05', :category_name => I18n.t('0.5% High Precision Resistors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '06', :category_name => I18n.t('1% High Precision Resistors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '07', :category_name => I18n.t('High Power Resistors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	@category2nd_id = Category2nd.where(:category_encoding => '02', :category1st_id => @category1st_id).first.id
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '01', :category_name => I18n.t('SMD Ceramic Capacitors - 0201 Package', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '02', :category_name => I18n.t('SMD Ceramic Capacitors - 0402 Package', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '03', :category_name => I18n.t('SMD Ceramic Capacitors - 0603 Package', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '04', :category_name => I18n.t('SMD Ceramic Capacitors - 0805 Package', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '05', :category_name => I18n.t('SMD Ceramic Capacitors - 1206 Package', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '06', :category_name => I18n.t('Chip Tantalum Capacitors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '07', :category_name => I18n.t('Aluminum Electrolytic Capacitors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)
  	Category3rd.create!(:category2nd_id => @category2nd_id, :category_encoding => '08', :category_name => I18n.t('Back-upBattery/ESD/EMI Capacitors', :scope => 'category_3rd_name'), :updated_by_email => @updated_by_email)  	
  end

  def down
  end
end
