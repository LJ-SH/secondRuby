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
      can :manage, AdminUser, :role => ROLE_DEFINITION[1..8]
      can :manage, [Category1st, Category2nd, Category3rd, Category4th, Category]
    elsif user.role? :MATERIAL_CONTROLLER
      can [:read, :update], AdminUser, :id => user.id
      can :manage, [Category1st, Category2nd, Category3rd, Category4th]
    else # OTHER role
      can :read, AdminUser, :id => user.id
      can :read, [Category1st, Category2nd, Category3rd, Category4th]
      #can :update, AdminUser, [:password]
    end

    if user.has_roles?(ROLE_DEFINITION[2..7])
      can [:read, :update], AdminUser, :id => user.id    
    end 
  end
end
