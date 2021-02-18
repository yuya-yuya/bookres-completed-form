class BooksController < ApplicationController
  before_action :authenticate_user!, :new_book
  before_action :correct_user, only: [:edit, :update]


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = 'Book was successfully created'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render "index"
    end
  end
  
  # @book.user_id = current_user.id足りてない

  def index
    @new_book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit　
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Book was successfully updated'
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end
  # エラーが出てない

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:success] = 'Book was successfully destroyed.'
    redirect_to books_path
  end
  
  # 「o」が抜けているスペルミス

  private

  def new_book
    @new_book = Book.new
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end

  # def correct_user
  #   user = Book.find(params[:id]).user
  #   if current_user.id != user.id
  #     redirect_to books_path
  #   end
  # end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
