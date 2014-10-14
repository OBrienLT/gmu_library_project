require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, book: { abstract: @book.abstract, author_id: @book.author_id, genre: @book.genre, image_cover_url: @book.image_cover_url, isbn: @book.isbn, pages: @book.pages, published_on: @book.published_on, title: @book.title, total_in_library: @book.total_in_library }
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book
    assert_response :success
  end

  test "should update book" do
    patch :update, id: @book, book: { abstract: @book.abstract, author_id: @book.author_id, genre: @book.genre, image_cover_url: @book.image_cover_url, isbn: @book.isbn, pages: @book.pages, published_on: @book.published_on, title: @book.title, total_in_library: @book.total_in_library }
    assert_redirected_to book_path(assigns(:book))
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book
    end

    assert_redirected_to books_path
  end
end
