class BookmarksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      flash[:success] = 'Weboookを追加しました。'
      redirect_to @user
    else
      @bookmarks = @user.bookmarks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Weboookを追加に失敗しました。'
      render @user
    end
  end

  def destroy
    @bookmark.destroy
    flash[:success] = 'Weboookを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :note, :link)
  end
  
  def correct_user
    @bookmark = current_user.bookmarks.find_by(id: params[:id])
    unless @bookmark
      redirect_to root_url
    end
  end
  
end