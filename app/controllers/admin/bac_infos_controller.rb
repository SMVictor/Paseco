module Admin
  class BacInfosController < ApplicationController
    layout 'admin'
    load_and_authorize_resource
    before_action :set_bac_info, only: [:edit, :update]

    def edit
    end

    def update
    respond_to do |format|
      if @bac_info.update(bac_info_params)
        format.html { redirect_to edit_admin_bac_info_url, notice: 'La información se actualizó correctamente.' }
        format.json { render json: @bac_info, status: :ok, location: @bac_info }
      else
        format.html { render :edit }
        format.json { render json: @bac_info.errors, status: :unprocessable_entity }
      end
    end
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_bac_info
        @bac_info = BacInfo.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def bac_info_params
         params.require(:bac_info).permit(:plan, :shipping, :date, :concept)
      end
  end
end
