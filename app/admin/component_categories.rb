ActiveAdmin.register ComponentCategory do
  	menu :parent => proc{I18n.t('system_setting')}	
	config.batch_actions = false	
	config.sort_order = "id_asc"
  	config.clear_sidebar_sections!	
  	actions  :all, :except => :show

	scope :level0, :default => true
	scope :level1
	scope :level2
	scope :level3

	collection_action :category_select do
		@category_type = params[:category_type]
		@component_category = ComponentCategory.new(:ancestry_depth => @category_type,:updated_by_email => current_admin_user.email)
		render :partial => "component_category_form", :object => @component_category
	end

	collection_action :level1_collection do
		unless params[:level0].empty? then
			@level1 = ComponentCategory.find(params[:level0]).children
		  	render :json => @level1.map{|c| [c.id, c.name]}
	  	else
	  		render :json => [["", I18n.t('category_sel_tip_option')]] 
	  	end
	end  

	collection_action :level2_collection do
		unless params[:level1].empty? 
		  	@level2 = ComponentCategory.find(params[:level1]).children
		  	render :json => @level2.map{|c| [c.id, c.name]}
	  	else
	  		render :json => [["", I18n.t('category_sel_tip_option')]] 
	  	end
	end  

	index do
	    column :name do |c|
			if c.end_node?
				c.name
			else
				@sql_search_hash = Hash.new
				c.path_ids.each_with_index {|item, index|
					@sql_search_hash[:"level#{index}_eq"] = item
				}
				#link_to c.name, admin_component_categories_url(:q => @sql_search_hash, :scope => "level#{c.depth+1}")
				link_to c.name, admin_component_categories_url(:q => {:subtree_eq => c.id}, :scope => "level#{c.depth+1}")
			end
	    end
		column :ancestry do |c|
			c.ancestor_display
		end unless params[:scope].blank? || params[:scope] == 'level0'
	    column :comment
	    column :updated_by_email
	    column :updated_at
	    default_actions
  	end

 	sidebar :filters, :only => :index do
 		@collection_ary = Array.new(3,[[I18n.t('active_admin.any'),""]])
 		@collection_ary[0] += ComponentCategory.level0.map{|r| [r.name, r.id]}
 		@level_val_ary = Array.new(3,"")

 		if params[:q] && (!params[:q][:subtree_eq].empty?)
 			@self_categoroy = ComponentCategory.find(params[:q][:subtree_eq])
 			unless @self_categoroy.nil? then
 				@ids = @self_categoroy.path_ids
 				@ids.each_with_index {|id, i|
 					@level_val_ary[i] = id unless id.nil?
 				}
 				@collection_ary[1] += ComponentCategory.find(@ids[0]).children.map{|r| [r.name, r.id]}
 				@collection_ary[2] += ComponentCategory.find(@ids[1]).children.map{|r| [r.name, r.id]} unless @ids[1].nil?
 			end
		end
 		render :partial => 'search', :locals => {:collection_ary => @collection_ary, :level_val_ary => @level_val_ary}
 	end	

  	form do |f|
  		render :partial => "component_category_form"
  	end 

	controller do 
	    before_filter :pre_proc

	    def pre_proc
	      case params[:action]
	        when 'new'
	          @component_category = ComponentCategory.new(:updated_by_email => current_admin_user.email)
	        when 'update'
	          params[:component_category].merge!(:updated_by_email => current_admin_user.email)        
	      end          
	    end

	    def destroy
	    	@component_category = ComponentCategory.find(params[:id])

	    	unless @component_category.nil?
	    		destroy!	    		
		        if @component_category.errors[:base].any?
		          flash[:error] ||= []
		          flash[:error].concat(@component_category.errors[:base]).map! {|msg| "<li>#{msg}</li>".html_safe}
		        end	    		
	    	end	
	    end
	end  	
end