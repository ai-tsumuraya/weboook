class KeepsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    bookmark = Bookmark.find(params[:bookmark_id])
    current_user.store(bookmark)
    flash[:success] = "Saved webook successfully"
    redirect_to user_path(current_user)
  end

  def destroy
    bookmark = Bookmark.find(params[:bookmark_id])
    current_user.unstore(bookmark)
    flash[:success] = "Unsaved webook."
    redirect_to user_path(current_user)
  end
end
