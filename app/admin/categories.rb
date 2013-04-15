ActiveAdmin.register Category do
  config.batch_actions = false	
  menu :parent => proc{I18n.t('system_setting')}
  config.sort_order = "id_asc"
  actions  :all, :except => :show
  config.clear_sidebar_sections!

  scope :level1, :default => true
  scope :level2
  scope :level3
  scope :level4

  form do |f|
    if f.object.new_record?
      render :partial => "new_category_form"
    else
      render :partial => "edit_category_form"
    end
  end

  index do
	  render "index", :context => self
  end

 	sidebar :filters, :only => :index do
 		@level1_collection = Category.level1.map{|c| [c.name, c.level1]}
 		if params[:q] && params[:q][:level1_eq]	
 			@level2_collection = Category.level2.where('level1 = ?', params[:q][:level1_eq]).map{|c| [c.name, c.level2]}
      if params[:q][:level2_eq]
        @level3_collection = Category.level3.where('level1 = ? and level2 = ?', params[:q][:level1_eq], params[:q][:level2_eq]).map{|c| [c.name, c.level3]}
      else
        @level3_collection = {}
      end
 		else
 		 	@level2_collection = {}
 		end
 		render :partial => 'search', :locals => {:level1_collection => @level1_collection, :level2_collection => @level2_collection, :level3_collection => @level3_collection}
 	end

  collection_action :level2_collection do
  	@level2 = Category.level2.where('level1 = ?', params[:level1])
  	render :json => @level2.map{|c| [c.level2, c.name]}
  end

  collection_action :level3_collection do
    @level3 = Category.level3.where('level1 = ? and level2 = ?', params[:level1], params[:level2])
    render :json => @level3.map{|c| [c.level3, c.name]}
  end

  collection_action :category_select do
    @category_type = params[:category_type]
    #if COMPONENT_CATEGORY_DEFINITION.include?(@category_type.to_sym)
    #  respond_to do |format|
    #    format .js {render "category_select", :layout => false, :locals => {:form_selected => @category_type.downcase + "_form"}}
    #  end
    #else 
    #  respond_to do |format|
    #    format .js {render "reset_category_select"}
    #  end
    #end
    @category = Category.new(:category_type => @category_type,:updated_by_email => current_admin_user.email)
    render :partial => "new_category_form", :object => @category
  end

	controller do 
    before_filter :pre_proc

    def pre_proc
      case params[:action]
        when 'new'
          @category = Category.new(:updated_by_email => current_admin_user.email)
        when 'update'
          params[:category].merge!(:updated_by_email => current_admin_user.email)
        when 'edit'
          logger.info flash[:error]          
      end          
    end    

		def index
			@level = params[:scope]? params[:scope] : "level1"
			index!
		end

    def destroy
      destroy!
    end

    def scoped_collection
      end_of_association_chain
    end 

  end
end
