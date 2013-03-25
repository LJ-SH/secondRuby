module ActiveAdmin::CategoriesHelper
	def index_name_helper(c,level)
		case level
			when "level1"
				link_to c.name, admin_categories_url(:q => {:level1_eq => c.level1}, :scope => "level2")
			when "level2"
				link_to c.name, admin_categories_url(:q => {:level1_eq => c.level1, :level2_eq => c.level2}, :scope => "level3")
			when "level3"
				link_to c.name, admin_categories_url(:q => {:level1_eq => c.level1, :level2_eq => c.level2, :level3_eq => c.level3}, :scope => "level4")
			else
				c.name
		end
	end	
	def index_code_helper(c,level)
		case level
			when "level1"
				c.level1
			when "level2"
				c.level2
			when "level3"
				c.level3
			else
				c.level4
		end		
	end
	def index_parent_helper(c,level)
		case level
			when "level1"
				""
			when "level2"
				Category.level1.where(:level1 => c.level1).first.name + "(#{c.level1})"
			when "level3"
				Category.level1.where(:level1 => c.level1).first.name + "(#{c.level1})" \
      			+ " - " + Category.level2.where(:level1 => c.level1, :level2 => c.level2).first.name + "(#{c.level2})"
			when "level4"
			    Category.level1.where(:level1 => c.level1).first.name + "(#{c.level1})" \
			    + " - " + Category.level2.where(:level1 => c.level1, :level2 => c.level2).first.name + "(#{c.level2})" \
			    + " - " + Category.level3.where(:level1 => c.level1, :level2 => c.level2, :level3 => c.level3).first.name + "(#{c.level3})"
			else 
				""
		end		
	end
	def category_collection_with_scope(type)
		if CATEGORY_MAP.has_key?(type)
			@level = CATEGORY_MAP[type]
		else
			@level = "level1"
		end
		admin_categories_url(:scope => @level)
	end
end