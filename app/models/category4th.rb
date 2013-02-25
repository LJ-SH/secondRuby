class Category4th < ActiveRecord::Base
	belongs_to :category3rd
	has_one :category2nd, :through => :category3rd
	has_one :category1st, :through => :category2nd

	attr_accessible :category_name, :category_encoding, :category_comment, :updated_by_email, :category3rd_id

	validates :category_encoding, :presence => true
	validates_format_of :category_encoding, :with => /^\d{2}$/
	validates :category_name,  :presence => { :case_sensitive => false }
	validates_uniqueness_of :category_encoding, :category_name, :scope => :category3rd_id
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	# update title for show action
	def display_name 
	  "#{category_name}(#{category_encoding})"
	end

	def nextLevelCategory
		nil
	end

	def nextCategoryIndexUrl(c)
		[:admin, c.category1st, c.category2nd, c.category3rd, c]
	end		
end
