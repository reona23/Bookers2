class FavoritesController < ApplicationController
  before_action :find_book

  def create
    @favorite = current_user.favorites.new(book_id: @book.id)
    if @favorite.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path, alert: 'いいねに失敗しました。')
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    if @favorite.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path, alert: 'いいねの削除に失敗しました。')
    end
  end

  private

  def find_book
    @book = Book.find(params[:book_id])
  end
end
