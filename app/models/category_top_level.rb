class CategoryTopLevel < ActiveRecord::Base
	has_many :category_second_levels, :dependent => :destroy
	#accepts_nested_attributes_for :category_second_levels

	attr_accessible :category_name

	validates :category_encoding, :uniqueness => true,  :presence => true
	validates_format_of :category_encoding, :with => /\d{2}/

	validates :category_name, :uniqueness => true,  :presence => { :case_sensitive => false }
	
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	# the default CategoryTopLevel.category_second_levels method collects all associated 2nd_category with CategoryTopLevel.id
	# if the reference is different, then the below method shall be overrided as below.
	#def category_second_levels
	#	CategorySecondLevel.where(:category_top_level_id => self.category_encoding)
	#end


end