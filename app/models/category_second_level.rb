class CategorySecondLevel < ActiveRecord::Base
	belongs_to :category_top_level
	accepts_nested_attributes_for :category_top_level

	validates :category_encoding, :presence => true
	validates_format_of :category_encoding, :with => /\d{2}/
	validates :category_name,  :presence => { :case_sensitive => false }
	validates_uniqueness_of :category_encoding, :category_name, :scope => :category_top_level_id
	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  	def index_title
  		logger.info "index_title invoked"
  		'works!'
  	end
end
