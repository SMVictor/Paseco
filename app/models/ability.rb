class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    elsif user.supervisor?
      can [:index, :edit, :add_role_lines, :update_role_lines], Role
    elsif user.human_resources?
      can [:index, :inactives, :show, :show_inactive, :update_vacations, :update_vacations_inactive, 
           :edit_vacations, :edit_vacations_inactive, :vacations_file, :new, :create, :edit, :update, 
           :edit_inactive, :update_inactive], Employee
      can [:index_payroles, :show_payroles, :payrole_detail], Role
    elsif user.sup_hr?
      can [:index, :inactives, :show, :show_inactive, :update_vacations, :update_vacations_inactive, 
           :edit_vacations, :edit_vacations_inactive, :vacations_file, :new, :create, :edit, :update, 
           :edit_inactive, :update_inactive], Employee
      can [:index, :edit, :add_role_lines, :update_role_lines], Role
    elsif user.psychologist?
      can [:index, :inactives, :show, :show_inactive, :edit_vacations, :edit_vacations_inactive, :vacations_file, 
           :edit, :edit_inactive], Employee
      can [:index, :entity], Download
      can [:index_payroles, :show_payroles, :payrole_detail], Role
    else
      can [:index_payroles, :payrole_detail], Role
    end
  end
end