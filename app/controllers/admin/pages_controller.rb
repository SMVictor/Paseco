module Admin
  class PagesController < ApplicationController

  	layout 'admin'

    def home
      @unregistered_employees = Employee.where(registered_account: false, active: true)
    end

    def update_home

      @employee = Employee.find(params[:id])
      @employee.update(registered_account: true)

      @unregistered_employees = Employee.where(registered_account: false, active: true)

      respond_to do |format|
        format.js
      end
    end

  end
end