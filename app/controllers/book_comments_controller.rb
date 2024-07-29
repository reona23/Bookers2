class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  before_action :set_book

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.build(book_comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "コメントを投稿しました"
    else
      flash[:danger] = "コメントを投稿できませんでした"
    end
    redirect_to book_path(@book)
  end

  def destroy
    @comment = @book.book_comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @book, notice: 'コメントが削除されました。'
    else
      redirect_to @book, alert: 'コメントの削除に失敗しました。'
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:book_comment).permit(:comment)
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    comment = BookComment.find(params[:id])
    unless comment.user_id == current_user.id
      flash[:danger] = "権限がありません"
      redirect_to book_path(comment.book)
    end
  end
end
