class AdminsController < ApplicationController
  before_action :authorize, :set_user, only: [:show, :edit, :update, :destroy]

# GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /admin
  # GET /admin.json
  def index
    @users = User.order(:name).page(params[:page])
  end

  # POST /admins
  # POST /admins.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admins_path, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_url, notice: "User #{@user.name} was successfully updated."}
        format.json { render :show, status: :ok, location: admin_url }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  protected

  def authorize
		unless User.find_by(id: session[:user_id])
			redirect_to login_url, notice: "Please log in"
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :user_id, :password, :password_confirmation, :admin)
    end

end
