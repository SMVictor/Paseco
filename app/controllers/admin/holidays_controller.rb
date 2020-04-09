module Admin
  class HolidaysController < ApplicationController
    layout 'admin'
    load_and_authorize_resource
    before_action :set_holiday, only: [:show, :edit, :update, :destroy]

    def index
      @holidays = Holiday.all.order(id: :asc)
    end

    def show
    end

    def new
      @holiday = Holiday.new
    end

    def edit
    end

    def create
    @holiday = Holiday.create(holiday_params)

      respond_to do |format|
        if @holiday.save
          format.html { redirect_to admin_holidays_url, notice: 'El feriado se creó correctamente.' }
          format.json { render json: @holiday, status: :created, location: @holiday }
        else
          format.html { render :new }
          format.json { render json: @holiday.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @holiday.update(holiday_params)
          format.html { redirect_to admin_holidays_url, notice: 'El feriado se actualizó correctamente.' }
          format.json { render json: @holiday, status: :ok, location: @holiday }
        else
          format.html { render :edit }
          format.json { render json: @holiday.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to admin_holidays_url, notice: 'El feriado se eliminó correctamente.' }
    end
  end

    private
      def set_holiday
        @holiday = Holiday.find(params[:id])
      end

      def holiday_params
        params.require(:holiday).permit(:name, :date)
      end
  end
end