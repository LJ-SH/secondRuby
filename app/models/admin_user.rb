class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:tlogin]

  # add virtual attribute to provide login flexbility (username or email)
  attr_accessor :tlogin     
  attr_accessible :tlogin

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role, :user_name, :telephone, :organization

  # TODO Enable MetaSearch to act as a string on DateTime fields
  search_methods :last_sign_in_at_contains

  before_destroy :prevent_if_lastone
  validates :user_name, :uniqueness => true,  :presence => { :case_sensitive => false }
  validates :email, :uniqueness => true, :presence => { :case_sensitive => false }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, :presence => { :case_sensitive => false }, :on => :create
  validates_format_of :telephone, :with => /^1[35]\d{9}$|^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/, :allow_blank => true 

  def prevent_if_lastone
  	if AdminUser.count < 2
      errors.add(:base, :destroy_fails_if_lastone)
      false # or errors.blank?
  	end
  end

  def has_roles?(roles)
    roles.include?(self.role)
  end

  def high_rank?(base_role)
    ROLE_DEFINITION.index(base_role) >= ROLE_DEFINITION.index(self.role)
  end

  def role? (role)
    ROLE_DEFINITION.index(role) == ROLE_DEFINITION.index(self.role)
  end

  def is_current_admin_user?(current_admin_user)
    id == current_admin_user.id
  end

  def is_default_admin_user?
    email == "admin@example.com"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:tlogin)
      where(conditions).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end  
end