module Admin
class CostCentersController < ApplicationController

  layout 'admin'

  before_action :set_cost_center, only: [:show, :edit, :update, :destroy]

  def index
    @cost_centers = CostCenter.all.order(name: :asc)
  end

  def show
  end

  def new
    @cost_center = CostCenter.new
  end

  def edit
  end

  def create
    @cost_center = CostCenter.create(cost_center_params)

    respond_to do |format|
      if @cost_center.save
        format.html { redirect_to admin_cost_centers_url, notice: 'El centro de costos se creó correctamente.' }
        format.json { render json: @cost_center, status: :created, location: @cost_center }
      else
        format.html { render :new }
        format.json { render json: @cost_center.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cost_center.update(cost_center_params)
        format.html { redirect_to admin_cost_centers_url, notice: 'El centro de costos se actualizó correctamente.' }
        format.json { render json: @cost_center, status: :ok, location: @cost_center }
      else
        format.html { render :edit }
        format.json { render json: @cost_center.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cost_center.destroy
    respond_to do |format|
      format.html { redirect_to admin_cost_centers_url, notice: 'El centro de costos se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost_center
      @cost_center = CostCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cost_center_params
      params.require(:cost_center).permit(:name, :province, :canton, :distric, :others, :customer_id)
    end
end
end