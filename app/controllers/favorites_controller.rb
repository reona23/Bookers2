class FavoritesController < ApplicationController
  before_action :find_book

  def create
    if already_favorited?
      flash[:notice] = "You can't favorite more than once"
    else
      @book.favorites.create(user_id: current_user.id)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if !(already_favorited?)
      flash[:notice] = "Cannot unfavorite"
    else
      @favorite = @book.favorites.find(params[:id])
      @favorite.destroy
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_book
    @book = Book.find(params[:book_id])
  end

  def already_favorited?
    Favorite.where(user_id: current_user.id, book_id: params[:book_id]).exists?
  end
end
