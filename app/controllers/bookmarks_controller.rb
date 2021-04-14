class BookmarksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      flash[:success] = 'Added webook successfully.'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = 'Faild to add webook.'
      render :new
    end
  end

  def destroy
    puts "deleting?"
    @bookmark.destroy
    flash[:success] = 'Deleted weboook successfully.'
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
