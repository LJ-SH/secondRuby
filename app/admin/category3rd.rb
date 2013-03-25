ActiveAdmin.register Category3rd do
  config.batch_actions = false
  menu false
  config.sort_order = "id_asc"

  index do    
    render "shared/category_index", :context => self, :collection => @category3rds
  end

  form do |f|
    render :partial => "shared/category_form", :locals => {:category => [:admin, category1st, category2nd, category3rd]}   
  end

  show do
    render "shared/category_show", :context => self
  end

  filter :category_name
  filter :updated_by_email, :as => :select, :collection => proc {Category3rd.uniq.pluck(:updated_by_email)}
  filter :updated_at  

  sidebar 'associate_category_information' do
    if params[:category1st_id] && params[:category2nd_id]
      @category = Category2nd.find(params[:category2nd_id])
      attributes_table_for @category do
        row :category1st 
        row (t 'category_2nd_info') { @category.display_name}
      end
      button_to(I18n.t('back_to_category_list'), {:action => :index}, :method => "get") if params[:action]=="show" 
    end
  end

  controller do 
    nested_belongs_to :category1st, :category2nd
    before_filter :pre_proc

    def update
      update! do |success, failure|
        success.html { return redirect_to url_for(:action => 'index')}
        failure.html { render active_admin_template('edit') }
      end
    end

    def create
      update! do |success, failure|
        success.html { return redirect_to url_for(:action => 'index')}
        failure.html { render active_admin_template('new') }
      end
    end

    def pre_proc 
      case params[:action]
        when 'new'
          @category3rd = Category3rd.new(:updated_by_email => current_admin_user.email, :category2nd_id => params[:category2nd_id], :category_encoding => Category3rd.where(:category2nd_id => params[:category2nd_id]).maximum("category_encoding").to_i+1)
        when 'update'
          params[:category3rd].merge!(:updated_by_email => current_admin_user.email)
      end
    end

  end  
end

  #index do    
  #  column :category_name, :sortable => :id do |c|
  #    #if c.category4ths.empty?
  #    if true
  #      @class_name = ""
  #    else
  #      @class_name = 'highlighted'
  #    end
  #    div :class => @class_name do 
  #    #  link_to c.category_name, admin_category1st_category2nd_category3rd_category4ths_path(c.category2nd,c)
  #    c.category_name
  #    end
  #  end                      
  #  column :category_encoding
  #  column :category_comment                    
  #  column :updated_at
  #  column :updated_by_email
  #  default_actions
  #end

  #form do |f|                         
  #  f.inputs I18n.t 'category_form_edit_table_title' do       
  #    f.input :category_encoding
  #    f.input :category_name
  #    f.input :category_comment
  #    f.input :updated_by_email, :as => :hidden
  #  end                               
  #  f.actions                         
  #end
