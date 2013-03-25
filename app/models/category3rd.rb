class Category3rd < ActiveRecord::Base
	belongs_to :category2nd
	has_one :category1st, :through => :category2nd
	has_many :category4ths, :dependent => :destroy

	attr_accessible :category_name, :category_encoding, :category_comment, :updated_by_email, :category2nd_id

	validates :category_encoding, :presence => true
	validates_format_of :category_encoding, :with => /^\d{2}$/
	validates :category_name,  :presence => { :case_sensitive => false }
	validates_uniqueness_of :category_encoding, :category_name, :scope => :category2nd_id
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

	# update title for show action
	def display_name 
	  "#{category_name}(#{category_encoding})"
	end

	def anyNextLevelCategory?
		self.category4ths.any?
	end

	def nextCategoryIndexUrl(c)
		[:admin, c.category1st, c.category2nd, c, :category4ths]
	end	
end
