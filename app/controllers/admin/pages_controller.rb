module Admin
  class PagesController < ApplicationController

  	layout 'admin'

    def home
      @unregistered_employees = Employee.where(registered_account: false, active: true)
    end
  end
end