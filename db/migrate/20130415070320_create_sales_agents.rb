class CreateSalesAgents < ActiveRecord::Migration
  def change
    create_table :sales_agents do |t|
      t.string 		:user_name
      t.string 		:password
      t.datetime 	:last_sign_in_at
      t.string   	:last_sign_in_ip      

	  t.string 		:company_name
	  t.string 		:address
	  t.string 		:postcode
	  t.string 		:service_desc

	  t.string 		:contact
	  t.string 		:contact_phone
	  t.string 		:contact_email

	  t.string 		:appendix_name
	  t.string 		:appendix_link

	  t.string 		:last_update_by	        
      #t.datetime 	:last_update_at  # leave this part to t.timestamps
      t.string   	:last_update_ip

      #created_at & updated_at
      t.timestamps
    end
  end
end