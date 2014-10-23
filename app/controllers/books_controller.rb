class BooksController < ApplicationController
  before_action :authorize
  respond_to :html, :xml, :json
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  
  # GET /books
  # GET /books.json
  def index
    if params[:search]
      @books = Book.search(params[:search]).order(:title).page(params[:page])
    else
      @books = Book.joins(:author).order(:title).page(params[:page])
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    # check_if_reserved
  end

  # GET /books/new
  def new
    @book = Book.new
    @author = Author.order(:name)
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    @author = Author.order(:name)
  end

  # POST /books
  # POST /books.json
  def create
    # @book = @author.books.new(book_params)
    # @book.author = @author

    # respond_to do |format|
    @author = Author.find(book_params[:author_id])
    @author.books.create(book_params)
    respond_with @author  do |format|
      if @author.save
        @book = Book.find_by(title: book_params[:title])
        format.html { redirect_to @book, notice: "The book called #{@book.title} was successfully created." }
      else
        format.html { render 'new', status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_url, notice: "The book #{@book.title} was successfully updated in the library." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "The book #{@book.title} was successfully deleted from the library." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
      @user = User.find(session[:user_id])
      @reservation = Reservation.where('book_id = ? and user_id = ?', @book.id, @user.id)
    end

    def set_author
      @author = Author.where('id = ?', :author)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :genre, :abstract, :pages, :image_cover_url, :published_on, :author_id, :total_in_library)
    end
end
