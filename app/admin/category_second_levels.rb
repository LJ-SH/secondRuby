ActiveAdmin.register CategorySecondLevel do
  belongs_to :category_top_level
  #scope_to :current_top_category
  #actions :all, :except => :show  
  menu false
  config.sort_order = "id_asc"

  index :title => proc {current_top_category.category_name} do             
    #selectable_column   
    #column :id      
    column I18n.t('level_2nd_name'), :category_name          
    column I18n.t('level_2nd_id'), :category_encoding
    column I18n.t('level_2nd_comment'), :category_comment                    
    column I18n.t('category_updated_at'), :updated_at
    column I18n.t('category_updated_by'), :updated_by_email
    default_actions
  end

  filter :category_top_level_id, :as => :select, :collection => CategoryTopLevel.all.map {|c| [c.category_name, c.id]}
  filter :category_name
  filter :updated_by_email, :as => :select, :collection => proc {[] | CategorySecondLevel.all.collect {|c| c.updated_by_email}}
  filter :updated_at  

  sidebar :upper_category_information, :only => :index do
    if params[:category_top_level_id]
      @current_category = CategoryTopLevel.find(params[:category_top_level_id])
      attributes_table_for @current_category do
        row :category_name
        row :category_comment
      end
    end
  end

  controller do   
    private
    def current_top_category
      if params[:category_top_level_id]
        @current_category = CategoryTopLevel.find(params[:category_top_level_id]);
      else
        @current_category = CategoryTopLevel.find(1);
      end
    end  
  end  
end