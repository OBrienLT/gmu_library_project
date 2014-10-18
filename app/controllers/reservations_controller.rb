class ReservationsController < ApplicationController
	before_action :set_user_book, only: [:create]

	# GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.joins(:book)
    									.where('user_id = ?', params[:user_id])
    									.order(:reserved_on).page(params[:page])
  end

  # POST /reservations
  # POST /reservations.json
  def create
  	@reservation = Reservation.new(user_id: @user.id, book_id:@book.id)
  	
#
    respond_to do |format|
      if @reservation.save
      	if @book.save
      		format.html { redirect_to user_reservations_url, notice: "#{@reservation.book.title} has been reserved to you." }
        	format.json { render :show, status: :created, location: @reservation }
        else
        	format.html { render :new }
        	format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    respond_to do |format|
      @book = Book.find(params[:book_id])
      @book.total_in_library = @book.total_in_library + 1

      if @book.save
        format.html { redirect_to user_reservations_path(session[:user_id]), notice: "#{@book.title} was returned successfully." }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_book
      @book = Book.find(params[:book_id])
      @book.total_in_library = @book.total_in_library - 1
  		@user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:user_id)
    end
end
