module Admin
  class UsersController < ApplicationController
    
    layout 'admin'
    load_and_authorize_resource
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.all.order(name: :asc)
    end

    def show
    end

    def new
      @user = User.new
    end

    def edit
    end

    def create
      @user = User.create([
      {identification: params[:user][:identification], name: params[:user][:name], email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], role: params[:user][:role], stall_ids: params[:user][:stall_ids]}]).first

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_url, notice: 'El usuario se creó correctamente.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_url, notice: 'El usuario se actualizó correctamente.' }
          format.json { render json: @user, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: 'El usuario se eliminó correctamente.' }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params[:user][:role] = params[:user][:role].to_i
        params.require(:user).permit(:identification, :name, :email, :role, stall_ids: [])
      end
  end
end