class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_author, only: [:create]

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
    @author = Author.order(:name).page(params[:page])
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    # @book = @author.books.new(book_params)
    # @book.author = @author

    # respond_to do |format|
    @book = @author.books.new(book_params)
    respond_with @author, @book  do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { redirect_to new_book_path, notice: "The Book #{@book.author.name}" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
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
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
      @user = User.find(session[:user_id])
    end

    def set_author
      @author = Author.where('id = ?', :author)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :genre, :abstract, :pages, :image_cover_url, :published_on, :total_in_library, :author)
    end
end
