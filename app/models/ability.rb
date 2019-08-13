class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    elsif user.manager?
      can [:index, :show, :edit, :add_role_lines, :update_role_lines], Role
    elsif user.human_resources?
      can [:index, :inactives, :show, :show_inactive, :update_vacations, :update_vacations_inactive, :edit_vacations, :edit_vacations_inactive], Employee
    else
      can [:index_payroles, :payrole_detail], Role
    end
  end
end