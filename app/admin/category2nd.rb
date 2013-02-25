ActiveAdmin.register Category2nd do
  config.batch_actions = false  
  belongs_to :category1st
  config.sort_order = "id_asc"

  index do    
    render "shared/category_index", :context => self, :collection => @category2nds
  end

  form do |f|
   render :partial => "shared/category_form", :locals => {:category => [:admin, category1st, category2nd]}
  end

  show do
    render "shared/category_show", :context => self
  end

  filter :category_name
  filter :updated_by_email, :as => :select, :collection => proc {[] | Category2nd.all.collect {|c| c.updated_by_email}}
  filter :updated_at  

  sidebar 'associate_category_information' do
    if params[:category1st_id]
      @category = Category1st.find(params[:category1st_id])
      attributes_table_for @category do
        row (t 'category_1st_info') { @category.display_name}
      end
      button_to(I18n.t('back_to_category_list'), {:action => :index}, :method => "get") if params[:action]=="show" 
    end
  end

  controller do 
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
          @category2nd = Category2nd.new(:updated_by_email => current_admin_user.email, :category1st_id => params[:category1st_id], :category_encoding => Category2nd.where(:category1st_id => params[:category1st_id]).maximum("category_encoding").to_i+1)
        when 'update'
          params[:category2nd].merge!(:updated_by_email => current_admin_user.email)
      end
    end

  end  
end

  #actions :all, :except => :show  
  # belongs_to will disable activeadmin menu by default
  #menu false

  #index do    
  #  column :category_name, :sortable => :id do |c|
  #    if c.category3rds.empty?
  #      @class_name = ""
  #    else
  #      @class_name = 'highlighted'
  #    end
  #    div :class => @class_name do 
  #      link_to c.category_name, admin_category1st_category2nd_category3rds_path(c.category1st,c)
  #    end
  #  end                      
  #  column :category_encoding
  #  column :category_comment                    
  #  column :updated_at
  #  column :updated_by_email
  #  column :actions do |c|
  #    links = ''.html_safe
  #    links += link_to I18n.t('active_admin.edit'), edit_resource_path(c), :class => "member_link edit_link"
  #    links += link_to I18n.t('active_admin.delete'), resource_path(c), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
  #    links
  #  end
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