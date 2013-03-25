ActiveAdmin.register Category4th do
  config.batch_actions = false
  menu false
  config.sort_order = "id_asc"

  index do    
    render "shared/category_index", :context => self, :collection => @category4ths
  end

  form do |f|
    render :partial => "shared/category_form", :locals => {:category => [:admin, category1st, category2nd, category3rd, category4th]}   
  end

  show do
    render "shared/category_show", :context => self
  end

  filter :category_name
  filter :updated_by_email, :as => :select, :collection => proc {Category4th.uniq.pluck(:updated_by_email)}
  filter :updated_at  

  sidebar 'associate_category_information' do
    if params[:category1st_id] && params[:category2nd_id] && params[:category3rd_id]
      @category = Category3rd.find(params[:category3rd_id])
      attributes_table_for @category do
        row :category1st
        row (t 'category_2nd_info') {link_to(@category.category2nd.display_name, admin_category1st_category2nd_path(@category.category1st, @category.category1st))}
        row (t 'category_3rd_info') { @category.display_name}
      end
      button_to(I18n.t('back_to_category_list'), {:action => :index}, :method => "get") if params[:action]=="show" 
    end
  end

  controller do 
    nested_belongs_to :category1st, :category2nd, :category3rd
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
          @category4th = Category4th.new(:updated_by_email => current_admin_user.email, :category3rd_id => params[:category3rd_id], :category_encoding => Category4th.where(:category3rd_id => params[:category3rd_id]).maximum("category_encoding").to_i+1)
        when 'update'
          params[:category4th].merge!(:updated_by_email => current_admin_user.email)
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
