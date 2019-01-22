module Admin
class StallsController < ApplicationController
  
  layout 'admin'

  before_action :set_stall, only: [:show, :edit, :update, :destroy]

  def index
    @stalls = Stall.all.order(customer_id: :asc)
  end

  def show
  end

  def new
    @stall = Stall.new
  end

  def edit
  end

  def create
    @stall = Stall.create(stall_params)

    respond_to do |format|
      if @stall.save
        format.html { redirect_to admin_stalls_url, notice: 'El puesto se creó correctamente.' }
        format.json { render json: @stall, status: :created, location: @stall }
      else
        format.html { render :new }
        format.json { render json: @stall.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stall.update(stall_params)
        format.html { redirect_to admin_stalls_url, notice: 'El puesto se actualizó correctamente.' }
        format.json { render json: @stall, status: :ok, location: @stall }
      else
        format.html { render :edit }
        format.json { render json: @stall.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stall.destroy
    respond_to do |format|
      format.html { redirect_to admin_stalls_url, notice: 'El puesto se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stall
      @stall = Stall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stall_params
      params.require(:stall).permit(:name, :description, :province, :canton, :district, :other, :customer_id, :payment_id, :daily_viatical, :substalls, :min_salary, :extra_shift, requirements_attributes: [:id, :name, :shifts, :hours, :workers, :_destroy])
    end
end
end