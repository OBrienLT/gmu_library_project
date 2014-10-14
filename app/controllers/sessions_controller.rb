class SessionsController < ApplicationController
  before_action :set_user, only: [:create]

  def new
    @session = User.new
  end

  def create
    #redirect_to login_url, alert: user_params[:name]
    user = User.find_by(name: user_params[:name])
    if user and user.authenticate(user_params[:password])
      session[:user_id] = user.id
      session[:admin] = user.admin
      redirect_to books_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(name: params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
