class Category1st < ActiveRecord::Base
	#include Rails.application.routes.url_helpers
	has_many :category2nds, :dependent => :destroy
	has_many :category3rds, :dependent => :destroy, :through => :category2nds
	has_many :category4ths, :dependent => :destroy, :through => :category3rds
	#accepts_nested_attributes_for :category_second_levels

	attr_accessible :category_name, :category_encoding, :category_comment, :updated_by_email

	validates :category_encoding, :uniqueness => true,  :presence => true
	# A common pitfall in Ruby’s regular expressions is to match the string’s beginning and end by ^ and $, instead of \A and \z.
	validates_format_of :category_encoding, :with => /\A\d{2}$\z/ 
	validates :category_name, :uniqueness => true,  :presence => { :case_sensitive => false }
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	# update title for show action
	def display_name 
	  "#{category_name}(#{category_encoding})"
	end

	def anyNextLevelCategory?
		self.category2nds.any?
	end

	def nextCategoryIndexUrl(c)
		[:admin, c, :category2nds]
	end

	# the below part is only needed for scope_to concept
	# the default CategoryTopLevel.category_second_levels method collects all associated 2nd_category with CategoryTopLevel.id
	# if the reference is different, then the below method shall be overrided as below.
	#def category_second_levels
	#	CategorySecondLevel.where(:category1st_id => self.category_encoding)
	#end
end