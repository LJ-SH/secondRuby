class Category < ActiveRecord::Base
	CATEGORY_MAP = {:CATEGORY_LEVEL1 => "level1", :CATEGORY_LEVEL2 => "level2", :CATEGORY_LEVEL3 => "level3", :CATEGORY_LEVEL4 => "level4"}
	validates_format_of :level1, :with => /\A\d{2}$\z/ 
	validates_format_of :level2, :with => /\A\d{2}$\z/ 
	validates_format_of :level3, :with => /\A\d{2}$\z/ 
	validates_format_of :level4, :with => /\A\d{2}$\z/ 	
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates_presence_of :name
	validates_uniqueness_of :level1, :name, :if => :level1?
	validates_uniqueness_of :level2, :name, :scope => [:level1], :if => :level2?	
	validates_uniqueness_of :level3, :name, :scope => [:level1, :level2], :if => :level3?
	validates_uniqueness_of :level4, :name, :scope => [:level1, :level2, :level3], :if => :level4?			
	validates_inclusion_of :category_type, :in => COMPONENT_CATEGORY_DEFINITION

	scope :level1, where(:category_type => :CATEGORY_LEVEL1)
	scope :level2, where(:category_type => :CATEGORY_LEVEL2)
	scope :level3, where(:category_type => :CATEGORY_LEVEL3)
	scope :level4, where(:category_type => :CATEGORY_LEVEL4)

	attr_accessible :name, :level1, :level2, :level3, :level4, :updated_by_email, :comment, :category_type

	def display_name
		"#{name}(#{level1}-#{level2}-#{level3}-#{level4})"
	end

	def level1?
		self.category_type == :CATEGORY_LEVEL1
	end
	def level2?
		self.category_type == :CATEGORY_LEVEL2
	end
	def level3?
		self.category_type == :CATEGORY_LEVEL3
	end
	def level4?
		self.category_type == :CATEGORY_LEVEL4
	end			
end
