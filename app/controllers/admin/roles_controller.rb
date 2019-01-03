module Admin
class RolesController < ApplicationController

  layout 'admin'
  
  before_action :set_role, only: [:show, :edit, :update, :destroy, :add_role_lines]

  def index
    @roles = Role.all.order(start_date: :desc)
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
    @role.update(stall_ids: Stall.all.ids)
  end

  def create
    @role = Role.create(role_params)
    @employees = Employee.all
    @employees.each do |employee|
      @role.payrole_lines.create([{ min_salary: '0', extra_hours: '0', daily_viatical: '0', ccss_deduction: '0', extra_payments: '0', deductions: '0', net_salary: '0', employee_id: employee.id }])
    end

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_roles_url, notice: 'El role se creó correctamente.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to admin_roles_url, notice: 'El role se actualizó correctamente.' }
        format.json { render json: @role, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_url, notice: 'El role se eliminó correctamente.' }
    end
  end

  def add_role_lines
    @stall = Stall.find(params[:stall_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :start_date, :end_date, stall_ids: [], role_lines_attributes: [:id, :date, :employee_id, :stall_id, :shift_id, :substall, :hours, :_destroy])
    end
end
end
