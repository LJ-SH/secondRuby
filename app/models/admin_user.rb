class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  attr_accessor :login     

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role, :user_name, :login

  before_destroy :prevent_if_lastone
  validates :user_name, :uniqueness => true,  :presence => { :case_sensitive => false }
  validates :email, :uniqueness => true, :presence => { :case_sensitive => false }
  validates :password, :presence => { :case_sensitive => false }, :on => :create

  def prevent_if_lastone
  	if AdminUser.count < 4
      errors.add(:base, :destroy_fails_if_lastone)
      false # or errors.blank?
  	end
  end

  def is_current_admin_user?(current_admin_user)
    id == current_admin_user.id
  end

  def is_default_admin_user?
    email == "admin@example.com"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end  
end