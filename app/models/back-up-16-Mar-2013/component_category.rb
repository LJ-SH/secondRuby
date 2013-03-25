class ComponentCategory < ActiveRecord::Base
	has_many :child_categories, :class_name => "ComponentCategory", :foreign_key => "parent_category_id"
	belongs_to :parent_category, :class_name => "ComponentCategory"

	validates :code, :presence => true	
	validates :name, :presence => { :case_sensitive => false }	
	validates_presence_of :parent_category_id, :if => Proc.new {:level != "top"}
	validates_uniqueness_of :name, :scope => :parent_category_id
	validates_uniqueness_of :code, :scope => :parent_category_id
	validates_format_of :code, :with => /\A\d{2}$\z/ 
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i		
	validates_inclusion_of :level, :in => COMPONENT_CATEGORY_DEFINITION

	scope :top_category, where(:level => "top")
	scope :second_category, where(:level => "2nd_level")
	scope :third_category, where(:level => "3rd_level")
	scope :end_category, where(:level => "end")

	attr_accessible :level, :name, :code, :level1

	def display_name
		"#{name}(#{code})"
	end

	def is_end_level?
		self.level == :end
	end

	def is_top_level?
		self.level == :top
	end

	def parent_name
		if self.is_top_level?
			return ""
		else
			@parent = self.parent_category
			"#{@parent.name}(#{@parent.code})"
		end
	end

	def level1
		self.parent_category.code unless self.parent_category.nil?
	end

	

	def level2
	end
end
