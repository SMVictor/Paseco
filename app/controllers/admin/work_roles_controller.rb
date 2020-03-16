module Admin
class WorkRolesController < ApplicationController

  layout 'admin'

  load_and_authorize_resource
  before_action :set_role, only: [:destroy, :edit, :update, :show, :add_role_lines]
  before_action :set_stall, only: [:add_role_lines]

  def index
    temporal_roles = WorkRole.all
    @roles = []
    temporal_roles.each do |role|
      if @roles[0] == nil
        @roles << role
      else
        flat = true
        @roles.each_with_index do |listed_role, index|
          if role.start_date.to_date > listed_role.start_date.to_date
            @roles.insert(index, role)
            flat = false
            break
          end
        end
        if flat
          @roles << role
        end
      end
    end 
  end

  def show
  end

  def new
    @role = WorkRole.new
  end

  def edit
  end

  def create
    @role = WorkRole.create(work_role_params)
    
    respond_to do |format|
      if @role.save

        Stall.where(active: true).each do |stall|
          stall.employees.where(active: true).each do |employee|
            (@role.start_date.to_date..@role.end_date.to_date).each do |date|
              WorkRoleLine.create(date: date, employee_id: employee.id, stall_id: stall.id, work_role_id: @role.id)
            end
          end
        end

        format.html { redirect_to admin_work_roles_url, notice: 'El role se creó correctamente.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(work_role_params)
        format.html { redirect_to admin_work_roles_url, notice: 'El role se actualizó correctamente.' }
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
      format.html { redirect_to admin_work_roles_url, notice: 'El role se eliminó correctamente.' }
    end
  end

  def add_role_lines

    @role_lines = @role.work_role_lines.where(stall_id: @stall.id).order(date: :asc) if @stall

    @substalls = []
    @count = 1

    if @stall
      while @count <= @stall.substalls.to_i
        @substalls[@count-1] = "Puesto " + @count.to_s
        @count = @count+1
      end
    end

    @days = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"]

    if params[:ajax]
      respond_to do |format|
        format.js
      end
    end

  end

  def update_role_lines
    changes = params[:changes].values
    changes.each do |change|
      line = WorkRoleLine.find(change[:id].to_i)
      line.sub_stall  = change[:sub_stall] if change[:sub_stall]
      line.shift_id   = change[:shift_id]  if change[:shift_id]
      line.save
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = WorkRole.find(params[:id])
    end

    def set_stall
      @stall = Stall.find(params[:stall_id]) if params[:stall_id] != "0"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_role_params
      params.require(:work_role).permit(:name, :start_date, :end_date)
    end
  end
end
