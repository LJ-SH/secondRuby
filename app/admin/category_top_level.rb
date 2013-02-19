ActiveAdmin.register CategoryTopLevel do
  actions :all, :except => :show
  menu :parent => I18n.t(:system_setting)
  config.sort_order = "id_asc"

  index do             
    #selectable_column   
    #column :id
    column I18n.t('level_1st_name'), :sortable => :id do |c|
      if c.category_second_levels.empty?
        c.category_name
      else
        link_to c.category_name, admin_category_second_levels_path(:category_top_level_id => c.id)
      end
    end       
    column I18n.t('level_1st_id'), :category_encoding, :sortable => false
    column I18n.t('level_1st_comment'), :category_comment                     
    column I18n.t('category_updated_at'), :updated_at
    column I18n.t('category_updated_by'), :updated_by_email
    default_actions
  end   

  form do |f|                         
    f.inputs I18n.t 'category_top_level_edit_table_title' do       
      f.input :category_encoding
      f.input :category_name
      f.input :category_comment
      f.input :updated_by_email, :as => :hidden
    end                               
    f.actions                         
  end 

  filter :category_name
  filter :updated_by_email, :as => :select, :collection => proc {email_list=[] | CategoryTopLevel.all.collect {|c| c.updated_by_email}}
  filter :updated_at

  controller do 
    def update
      # add the updated account information
      params[:category_top_level].merge!(:updated_by_email => current_admin_user.email)
      super
    end
    def new
      # add the updated account information
      @category_top_level = CategoryTopLevel.new(:updated_by_email => current_admin_user.email)
      super
    end
  end
end
