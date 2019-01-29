class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    elsif user.manager?
      can [:index, :show, :create, :update, :destroy], Role
    else
      can [:index, :show, :create, :update, :destroy], Role
    end
  end
end