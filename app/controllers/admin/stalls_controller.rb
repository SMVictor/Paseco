module Admin
class StallsController < ApplicationController
  
  layout 'admin'
  load_and_authorize_resource
  before_action :set_stall, only: [:show, :show_inactive, :edit, :edit_inactive, :update, :update_inactive, :destroy]

  def index
    @stalls = Stall.where(active: true).order(name: :asc)
  end

  def inactives
    if params[:ids]
      @stalls = Stall.where(id: params[:ids], active: false).order(name: :asc)
      respond_to do |format|
        format.js
      end
    else
      @stalls = Stall.where(active: false).order(name: :asc)
    end
  end

  def show
  end

  def show_inactive
  end

  def new
    @stall = Stall.new
  end

  def edit
  end

  def edit_inactive
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

  def update_inactive
    respond_to do |format|
      if @stall.update(stall_params)
        if params[:stall][:active] != nil && params[:stall][:active] == "1"
          @stall.customer.active = true
          @stall.customer.save
        end
        format.html { redirect_to admin_inactive_stalls_url, notice: 'El puesto se actualizó correctamente..' }
        format.json { render json: @stall, status: :ok, location: @stall }
      else
        format.html { render :edit_inactive }
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

  def destroy_inactive
    @stall.destroy
    respond_to do |format|
      format.html { redirect_to admin_inactive_stalls_url, notice: 'El puesto se eliminó correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stall
      @stall = Stall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stall_params
      params.require(:stall).permit(:name, :description, :province, :canton, :district, :other, :customer_id, :quote_id, :daily_viatical, :substalls, :night_min_salary, :min_salary, :extra_shift, :active)
    end
end
end