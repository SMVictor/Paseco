class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    elsif user.manager?
      can [:index, :show, :create, :update, :add_role_lines, :update_role_lines, :approvals, :check_changes, :approve_create, :approve_update, :approve_destroy, :deny_change, :index_payroles, :show_payroles], Role
    else
      can [:index, :show, :edit, :add_role_lines, :update_role_lines], Role
    end
  end
end