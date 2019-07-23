module Admin
  class PagesController < ApplicationController

  	layout 'admin'

    def home
      @unregistered_employees = Employee.where(registered_account: false, active: true)
    end

    def update_home
      @unregistered_employees = Employee.where(registered_account: false, active: true)
      @employee = Employee.find(params[:id])
      @employee.registered_account = true
      @employee.save
      respond_to do |format|
        format.js
      end
    end

  end
end