ActiveAdmin.register Category1st do
  config.batch_actions = false
  menu :parent => I18n.t('system_setting')
  controller.authorize_resource
  config.sort_order = "id_asc"

  index do    
    render "shared/category_index", :context => self, :collection => @category1sts
  end  
  
  form do |f|
   render :partial => "shared/category_form", :locals => {:category => [:admin, category1st]}
  end

  show do
    render "shared/category_show", :context => self
  end

  filter :category_name
  filter :updated_by_email, :as => :select, :collection => proc {email_list=[] | (Category1st.all).collect {|c| c.updated_by_email}}
  filter :updated_at

  sidebar 'associate_category_information', :only => :show do |c|
    button_to(I18n.t('back_to_category_list'), {:action => :index}, :method => "get")
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
          @category1st = Category1st.new(:updated_by_email => current_admin_user.email, :category_encoding => Category1st.maximum("category_encoding").to_i+1)
        when 'update'
          params[:category1st].merge!(:updated_by_email => current_admin_user.email)
      end
    end   
  end
end

  # note - the below defintion a conveinient way to remove 'show' action link from default_actions, but
  # it will also disable 'resource#action' links which make some nested-resource link broken
  # so that we have to manually define column actions as well as update action
  #actions :all, :except => :show

  #index do             
  #  column :category_name, :sortable => :id do |c|
  #    if c.category2nds.empty?
  #      @class_name = ""
  #    else
  #      @class_name = 'highlighted'
  #    end
  #    div :class => @class_name do 
  #      link_to c.category_name, [:admin, c, :category2nds]
  #    end
  #  end       
  #  column :category_encoding, :sortable => false
  #  column :category_comment                     
  #  column :updated_at
  #  column :updated_by_email   
    #default_actions
  #  column :actions do |c|
  #    links = ''.html_safe
  #    links += link_to I18n.t('active_admin.edit'), edit_resource_path(c), :class => "member_link edit_link"
  #    links += link_to I18n.t('active_admin.delete'), resource_path(c), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
  #    links
  #  end
  #end 

  # form :title => :category_name do |f|                         
  #   f.inputs I18n.t 'category_form_edit_table_title' do       
  #    f.input :category_encoding
  #    f.input :category_name
  #    f.input :category_comment
  #    f.input :updated_by_email, :as => :hidden
  #  end                               
  #  f.actions                         
  # end 

  #show do |c|
  #  attributes_table do
  #    row :category_name
  #    row :category_encoding
  #    row :category_comment                     
  #    row :updated_at
  #    row :updated_by_email    
  #  end
  #end


