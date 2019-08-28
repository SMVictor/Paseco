module Admin
  class BncrInfosController < ApplicationController
    layout 'admin'
    load_and_authorize_resource
    before_action :set_bncr_info, only: [:edit, :update]

    def edit
    end

    def update
    respond_to do |format|
      if @bncr_info.update(bncr_info_params)
        format.html { redirect_to edit_admin_bncr_info_url, notice: 'La información se actualizó correctamente.' }
        format.json { render json: @bncr_info, status: :ok, location: @bncr_info }
      else
        format.html { render :edit }
        format.json { render json: @bncr_info.errors, status: :unprocessable_entity }
      end
    end
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_bncr_info
        @bncr_info = BncrInfo.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def bncr_info_params
        params.require(:bncr_info).permit(:date, :company, :transfer_type, :consecutive, :concept, :account, :employee_concept)
      end
  end
end