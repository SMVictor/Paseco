module Admin
  class CcssPaymentsController < ApplicationController
    layout 'admin'
    load_and_authorize_resource
    before_action :set_ccss_payment, only: [:edit, :update]

    def index
      @roles = Role.where('id <= 18 or id >= 33').order(id: :asc)
    end

    def show
      @roles = []
      params[:ids].split(",").each do |id|
        @roles << id.to_i if id != "0"
      end
      payrole_lines = PayroleLine.where(role_id: @roles).order(:name)
      @employee_ids = []
      payrole_lines.each do |payrole|
        @employee_ids << payrole.employee.id
      end
      @employee_ids = @employee_ids.uniq

      respond_to do |format|
        format.html
        format.xls
      end
    end

    def edit
    end

    def update
    respond_to do |format|
      if @ccss_payment.update(ccss_payment_params)
        format.html { redirect_to edit_admin_ccss_payment_url, notice: 'La información se actualizó correctamente.' }
        format.json { render json: @ccss_payment, status: :ok, location: @ccss_payment }
      else
        format.html { render :edit }
        format.json { render json: @ccss_payment.errors, status: :unprocessable_entity }
      end
    end
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_ccss_payment
        @ccss_payment = CcssPayment.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def ccss_payment_params
        params.require(:ccss_payment).permit(:percentage, :amount, :retired_percentage)
      end
  end
end