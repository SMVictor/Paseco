module Admin
  class AreasController < ApplicationController
    layout 'admin'
    load_and_authorize_resource
    before_action :set_area, only: [:show, :edit, :update, :destroy]

    # GET /areas
    # GET /areas.json
    def index
      @areas = Area.all.order(name: :asc)
    end

    # GET /areas/1
    # GET /areas/1.json
    def show
    end

    # GET /areas/new
    def new
      @area = Area.new
    end

    # GET /areas/1/edit
    def edit
    end

    # POST /areas
    # POST /areas.json
    def create
    @area = Area.create(area_params)

      respond_to do |format|
        if @area.save
          format.html { redirect_to admin_areas_url, notice: 'El área se creó correctamente.' }
          format.json { render json: @area, status: :created, location: @area }
        else
          format.html { render :new }
          format.json { render json: @area.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /areas/1
    # PATCH/PUT /areas/1.json
    def update
      respond_to do |format|
        if @area.update(area_params)
          format.html { redirect_to admin_areas_url, notice: 'El área se actualizó correctamente.' }
          format.json { render json: @area, status: :ok, location: @area }
        else
          format.html { render :edit }
          format.json { render json: @area.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /areas/1
    # DELETE /areas/1.json
    def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to admin_areas_url, notice: 'El área se eliminó correctamente.' }
    end
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_area
        @area = Area.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def area_params
        params.require(:area).permit(:name, :description)
      end
  end
end
