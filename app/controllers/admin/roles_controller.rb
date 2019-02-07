module Admin
class RolesController < ApplicationController

  layout 'admin'
  load_and_authorize_resource
  before_action :set_role, only: [:show, :edit, :update, :destroy, :add_role_lines, :update_role_lines, :approvals, :check_changes]
  before_action :set_stall, only: [:update_role_lines, :add_role_lines, :check_changes]

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

  def update_role_lines
    if current_user.admin? || current_user.manager?
      respond_to do |format|
        if @role.update(role_params)
          format.html { redirect_to admin_role_lines_url, notice: 'El role se actualizó correctamente.' }
          format.json { render json: @role, status: :ok, location: @role }
        else
          format.html { render :edit }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    else
      params[:role][:role_lines_attributes].each do |key, value|

        begin
          @role_line = RoleLine.find(value[:id].to_i)
        rescue => ex
          @role_line = nil
        end

        if value[:_destroy] == "1"

          @role_line.role_lines_copy = RoleLinesCopy.new if @role_line.role_lines_copy == nil

          @role_line.role_lines_copy.date        = @role_line.date
          @role_line.role_lines_copy.substall    = @role_line.substall
          @role_line.role_lines_copy.employee_id = @role_line.employee_id
          @role_line.role_lines_copy.shift_id    = @role_line.shift_id
          @role_line.role_lines_copy.stall_id    = @role_line.stall.id
          @role_line.role_lines_copy.stall_id    = @role_line.stall.id
          @role_line.role_lines_copy.role_id     = @role_line.role.id
          @role_line.role_lines_copy.comment     = @role_line.comment
          @role_line.role_lines_copy.action      = "delete"
          @role_line.role_lines_copy.save

        elsif @role_line == nil

          @role_lines_copy = RoleLinesCopy.create(date: value[:date], substall: value[:substall], employee_id: value[:employee_id],
            shift_id: value[:shift_id], stall_id: @stall.id, role_id: @role.id, comment: value[:comment], action: "create")

        else
          @role_line.date        = value[:date]
          @role_line.substall    = value[:substall]
          @role_line.employee_id = value[:employee_id]
          @role_line.shift_id    = value[:shift_id]
          @role_line.comment     = value[:comment]
          if @role_line.changed?

            @role_line.role_lines_copy = RoleLinesCopy.new if @role_line.role_lines_copy == nil
            
            @role_line.role_lines_copy.date        = value[:date]
            @role_line.role_lines_copy.substall    = value[:substall]
            @role_line.role_lines_copy.employee_id = value[:employee_id]
            @role_line.role_lines_copy.shift_id    = value[:shift_id]
            @role_line.role_lines_copy.comment     = value[:comment]
            @role_line.role_lines_copy.stall_id    = @stall.id
            @role_line.role_lines_copy.role_id     = @role.id
            @role_line.role_lines_copy.action      = "update"
            @role_line.role_lines_copy.save
          end
        end
      end
      respond_to do |format|
        format.html { redirect_to admin_role_lines_url, notice: 'Su solicitud ha sido enviada para revisión.' }
        format.json { render json: @role, status: :ok, location: @role }
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
    @substalls = []
    @count = 1
    while @count <= @stall.substalls.to_i
      @substalls[@count-1] = "Puesto " + @count.to_s
      @count = @count+1
    end
  end

  def approvals 
  end

  def check_changes
    @changes = RoleLinesCopy.where(role_line_id: RoleLine.where("stall_id = ?", @stall.id).ids).or(RoleLinesCopy.where(stall_id: @stall.id))
  end

  def approve_create
    @change    = RoleLinesCopy.find(params[:change_id])
    @role_line = RoleLine.create(date: @change.date, substall: @change.substall, hours: @change.hours, role_id: @change.role_id, employee_id: @change.employee_id, stall_id: @change.stall_id, shift_id: @change.shift_id, comment: @change.comment)
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Los datos fueron registrados correctamente.' }
    end
  end

  def approve_update
    @change    = RoleLinesCopy.find(params[:change_id])
    @role_line = @change.role_line.update(date: @change.date, substall: @change.substall, hours: @change.hours, role_id: @change.role_id, employee_id: @change.employee_id, stall_id: @change.stall_id, shift_id: @change.shift_id, comment: @change.comment)
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Modificación exitosa.' }
    end
  end

  def approve_destroy
    @change    = RoleLinesCopy.find(params[:change_id])
    @role_line = @change.role_line.destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Los datos fueron eliminados correctamente.' }
    end
  end

  def deny_change
    @change    = RoleLinesCopy.find(params[:change_id])
    @change.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_role_changes_url, notice: 'Cambio denegado' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    def set_stall
      @stall = Stall.find(params[:stall_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :start_date, :end_date, stall_ids: [], role_lines_attributes: [:id, :date, :employee_id, :stall_id, :shift_id, :substall, :comment, :hours, :extra_payments, :extra_payments_description, :deductions, :deductions_description, :_destroy])
    end
end
end
