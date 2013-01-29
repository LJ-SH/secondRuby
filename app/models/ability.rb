class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= AdminUser.new
    if user.role? :SUPER_ADMIN
      can :manage, :all 
    elsif user.role? :ADMIN
      can :manage, :all, :role => ROLE_DEFINITION[1..8]
    elsif user.has_roles?(ROLE_DEFINITION[2..7])
      can [:read, :update], AdminUser, :id => user.id

    else # OTHER role
      can :read, AdminUser, :id => user.id
      #can :update, AdminUser, [:password]
    end

    
    #user ||= AdminUser.new
    #case user.role
    #    when :SUPER_ADMIN
    #      can :manage, :all    
    #    when :ADMIN
    #      can :manage, :all, :role => ROLE_DEFINITION[1..9] # 9 is the size of ROLE_DEFINITION
    #    when :DEV
    #      can [:read, :update], AdminUser, :id => user.id
    #      #can [:read, :update], AdminUser, :id => self.id, :role => :MATERIAL_CONTROLLER
    #    when :FIN
    #      can [:read, :update], AdminUser, :id => user.id
    #    when :PLM
    #      can [:read, :update], AdminUser, :id => user.id
    #    when :SALES
    #      can [:read, :update], AdminUser, :id => user.id
    #    when :MATERIAL_CONTROLLER
    #      can [:read, :update], AdminUser, :id => user.id
    #      cannot :update, AdminUser, :attribute => "role"
    #    when :POST_SALES
    #      can [:read, :update], AdminUser, :id => user.id
    #    when :OTHER 
    #      cannot :manage, :all
    #end

    #user ||= AdminUser.new
    #if user.has_role?([:SUPER_ADMIN])
    #  can :manage, :all 
    #elsif user.has_role?([:ADMIN])
    #  can :manage, :all, :role => ROLE_DEFINITION[1..8]
    #elsif user.has_role?(ROLE_DEFINITION[2..7])
    #  can [:read, :update], AdminUser, :id => user.id
    #else # OTHER role
    #  can :read, AdminUser, :id => user.id
    #end
  end
end
