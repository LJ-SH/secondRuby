class ComponentCategory < ActiveRecord::Base
	before_destroy :check_and_delete_children

	has_ancestry(:cache_depth => true)
	attr_accessor :level0, :level1, :level2, :subtree


	validates_inclusion_of :ancestry_depth, :in => [0,1,2,3]
	validates_presence_of :name
	validates_uniqueness_of :name, :scope => [:ancestry]
	#validates_format_of :level0, :with => /\A\d{2}$\z/
  	validates :updated_by_email, :presence => { :case_sensitive => false }	
  	validates_format_of :updated_by_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i	

	scope :level0, where(:ancestry_depth => 0)
	scope :level1, where(:ancestry_depth => 1)
	scope :level2, where(:ancestry_depth => 2)
	scope :level3, where(:ancestry_depth => 3)  

	def ancestor_display
		unless self.ancestors.nil? 
			@parents_name = self.ancestors.to_ary.map{|c| "#{c.name}(#{c.id})"}
			@parents_name.join("/")
		end
	end

	def end_node?
		self.ancestry_depth==3?  true:false
	end

	def level0
		#self.root_id.nil?? nil: self.root_id
		self.root_id
	end

	def level1
		#self.ancestor_ids[1].nil?? nil: self.ancestor_ids[1]
		self.ancestor_ids[1]
	end

	def level2
		#self.ancestor_ids[2].nil?? nil: self.ancestor_ids[2]
		self.ancestor_ids[2]
	end	

	def check_and_delete_children
		if self.ancestry_depth == 3 
			self.errors.add(:base, :destroy_fails_if_in_use, :categoryname => self.name)
			return false
		end		
		self.children.each do |c|
			unless c.destroy
				self.errors[:base].concat(c.errors[:base]);
				#self.errors.add(:base, :destroy_fails_if_children_exist, :childname => c.name)	
				return false
			end
		end
	end

	scope :level0_eq, lambda {|id| where("ancestry like ? or id = ?", "#{id}%", id)} #starts with id
	scope :level1_eq, lambda {|id| where("ancestry like ? or id = ?", "%#{id}%", id)}	
	scope :level2_eq, lambda {|id| where("ancestry like ? or id = ?", "%#{id}", id)} #ends with id
	scope :subtree_eq, lambda {|id| where("ancestry like ? or id = ?", "%#{id}%", id)}
	#scope :subtree_contains, lambda {|id| where("ancestry like ? or id = ?", "%#{id}%", id)}
	search_methods :level0_eq, :level1_eq, :level2_eq, :subtree_eq
end
