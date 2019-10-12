module Admin
  class QuotesController < ApplicationController

    layout 'admin'
    load_and_authorize_resource
    before_action :set_quote, only: [:show, :edit, :update, :destroy, :create_step1, :create_step2, :edit_step1, :edit_step2, :update_step1, :update_step2, :update_edit_step1, :update_edit_step2, :restore_quote]

    def index
      if params[:ids]
        @quotes = Quote.where(id: params[:ids]).all.order(number: :asc)
        respond_to do |format|
          format.js
        end
      else
        @quotes = Quote.all.order(number: :asc)
      end
    end

    def show
    end

    def new
      @quote = Quote.new
    end

    def edit
    end

    def create
      @quote = Quote.new(quote_params)

      respond_to do |format|
        if @quote.save
          format.html { redirect_to admin_create_quote_step2_url(@quote), notice: 'La acción se realizó correctamente.' }
          format.json { render json: @quote, status: :created, location: @quote }
        else
          format.html { render :new }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end

    def create_step1
    end

    def update_step1
      respond_to do |format|
        if @quote.update(quote_params)
          format.html { redirect_to admin_create_quote_step2_url, notice: 'La acción se realizó correctamente.' }
          format.json { render json: @quote, status: :ok, location: @quote }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end

    def create_step2
    end

    def update_step2
      respond_to do |format|
        if @quote.update(quote_params)
          format.html { redirect_to admin_quotes_url, notice: 'La acción se realizó correctamente.' }
          format.json { render json: @quote, status: :ok, location: @quote }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit_step1
    end

    def update_edit_step1
      respond_to do |format|
        if @quote.update(quote_params)
          format.html { redirect_to admin_edit_quote_step2_url, notice: 'La acción se realizó correctamente.' }
          format.json { render json: @quote, status: :ok, location: @quote }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit_step2
    end

    def update_edit_step2
      @copy = QuoteCopy.first.destroy

      respond_to do |format|
        if @quote.update(quote_params)
          format.html { redirect_to admin_quotes_url, notice: 'La acción se realizó correctamente.' }
          format.json { render json: @quote, status: :ok, location: @quote }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end

    def restore_step1
      @copy = QuoteCopy.first
      @quote.institution           = @copy.institution
      @quote.procedure_number      = @copy.procedure_number
      @quote.procedure_description = @copy.procedure_description
      @quote.payment_id            = @copy.payment_id
      @quote.daily_salary          = @copy.daily_salary
      @quote.night_salary          = @copy.night_salary
      @quote.save
      @copy.destroy

      respond_to do |format|
        format.html { redirect_to admin_quotes_url }
      end
    end

    def update
      @copy = QuoteCopy.new
      @copy.institution           = @quote.institution
      @copy.procedure_number      = @quote.procedure_number
      @copy.procedure_description = @quote.procedure_description
      @copy.payment_id            = @quote.payment_id
      @copy.daily_salary          = @quote.daily_salary
      @copy.night_salary          = @quote.night_salary
      @copy.save

      respond_to do |format|
        if @quote.update(quote_params)
          format.html { redirect_to admin_edit_quote_step2_url, notice: 'La acción se realizó correctamente.' }
          format.json { render json: @quote, status: :ok, location: @quote }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @quote.destroy
      respond_to do |format|
        format.html { redirect_to admin_quotes_url, notice: 'La acción se realizó correctamente.' }
      end
    end

    private

      def set_quote
        @quote = Quote.find(params[:id])
      end

      def quote_params
        params.require(:quote).permit(:type, :institution, :daily_salary, :night_salary, :procedure_number, :procedure_description, :salary, :officers, :holidays, :vacations, :payment_id, requirements_attributes: [:id, :position_id, :start_day, :end_day, :shift_id, :hours, :workers, :freeday_worker, :_destroy])
      end
  end
end
