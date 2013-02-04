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
    column :organization
    column :telephone
    column :last_sign_in_at
    #column :sign_in_count        
    default_actions                   
  end                                 

  filter :user_name  
  filter :email
  filter :organization
  filter :last_sign_in_at
  # TODO filter :last_sign_in_at, :as => :string, :input_html => {:class => "hasDatetimePicker"}

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :user_name
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
      if current_admin_user.has_roles?([:SUPER_ADMIN, :ADMIN])
        f.input :role, :as => :select, :collection => ROLE_DEFINITION.dup.drop_while{|x| x>current_admin_user.role}.map { |r| [I18n.t("role.#{r}"),r]}
        f.input :organization
      end
      f.input :telephone
      f.form_buffers.last # bypass the bug where no field will be shown if the unless condition is not satisfied
    end                               
    f.actions                         
  end               

  show do |admin_user|
    attributes_table do
      row :user_name      
      row :email                     
      #row :current_sign_in_at        
      #row :sign_in_count       
      row :role do 
        translated_role(admin_user)
      end
      row :organization
      row :telephone      
      row :last_sign_in_at           
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
      # enable the account modification without password update
      if params[:admin_user][:password].blank?
        params[:admin_user].delete("password")
        params[:admin_user].delete("password_confirmation")
      end
      # enable new role assignment shall not higher than the current user
      if params[:admin_user][:role]
        unless current_admin_user.role? params[:admin_user][:role].to_sym
            flash[:notice] = t(:insufficient_permission_on_role_assignment)
            redirect_to :action => :edit
            return
        end
      end
      super # call original destory method
    end
  end
end                                   
