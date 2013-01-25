ActiveAdmin.register AdminUser do  
  menu :parent => I18n.t(:system_setting)

  index do               
    selectable_column             
    column :user_name
    column :email                     
    #column :current_sign_in_at        
    column :role do |admin_user|
        translated_role(admin_user)
    end    
    column :last_sign_in_at           
    column :sign_in_count        
    default_actions                   
  end                                 

  filter :email
  filter :user_name         

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :user_name
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
      f.input :role, :as => :select, :collection => ROLE_DEFINITION.map { |r| [I18n.t("role.#{r}"),r]}
    end                               
    f.actions                         
  end               

  show do |admin_user|
    attributes_table do
      row :email                     
      #row :current_sign_in_at        
      row :last_sign_in_at           
      row :sign_in_count       
      row :role do 
        translated_role(admin_user)
      end
      row :user_name      
      #action_item
    end
  end        

  action_item :only => :show do 
    link_to I18n.t('back_to_admin_list'), :action => :index
  end   

  #batch_action :destroy, :if => proc { can?( :destroy, Post ) } do |selection|
  #  redirect_to collection_path, :alert => "Didn't really delete these!"
  #end  

  controller do 
    def destroy
      @admin_user = AdminUser.find(params[:id])

      # destroy fails if it's default admin account
      if @admin_user.is_default_admin_user?
          flash[:notice] = t(:no_destroy_on_default_admin_user)
          redirect_to :action => :index      
      # destroy fails if it's current user   
      elsif @admin_user.is_current_admin_user?(current_admin_user)
          flash[:notice] = t(:no_destroy_on_current_admin_user)
          redirect_to :action => :index
      else
        super # call original destory method
        if @admin_user.errors[:base].any?
          flash[:error] ||= []
          flash[:error].concat(@admin_user.errors[:base])
        end
      end
    end

    def update
      if params[:admin_user][:password].blank?
        params[:admin_user].delete("password")
        params[:admin_user].delete("password_confirmation")
      end
      super # call original destory method
    end
  end
end                                   
