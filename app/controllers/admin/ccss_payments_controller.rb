module Admin
  class CcssPaymentsController < ApplicationController
    layout 'admin'
    before_action :set_ccss_payment, only: [:edit, :update]

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
        params.require(:ccss_payment).permit(:percentage, :amount)
      end
  end
end