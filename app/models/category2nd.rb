class Category2nd < ActiveRecord::Base
	belongs_to :category1st
	has_many :category3rds, :dependent => :destroy
	has_many :category4ths, :dependent => :destroy, :through => :category3rds
	#accepts_nested_attributes_for :category1st

	attr_accessible :category_name, :category_encoding, :category_comment, :updated_by_email, :category1st_id

	validates :category_encoding, :presence => true
	validates_format_of :category_encoding, :with => /^\d{2}$/
	validates :category_name,  :presence => { :case_sensitive => false }
	validates_uniqueness_of :category_encoding, :category_name, :scope => :category1st_id
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	# update title for show action
	def display_name 
	  "#{category_name}(#{category_encoding})"
	end

	def nextLevelCategory
		self.category3rds.all
	end

	def nextCategoryIndexUrl(c)
		[:admin, c.category1st, c, :category3rds]
	end
end
