class KeepsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    bookmark = Bookmark.find(params[:bookmark_id])
    current_user.save(bookmark)
    flash[:success] = "Weboookをセーブしました。"
    redirect_to user_path(current_user)
  end

  def destroy
    bookmark = Bookmark.find(params[:bookmark_id])
    current_user.unsave(bookmark)
    flash[:success] = "Weboookをセーブから削除しました。"
    redirect_to user_path(current_user)
  end
end
