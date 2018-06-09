class LikesController < ApplicationController

  #used to render your unacknowledged likes
  def counter
    redirect_to root_path and return unless user_signed_in?

    @likes = unacknowledged_likes
  end

  def index
    redirect_to root_path and return unless user_signed_in?

    @likes = all_likes.page(@page).per(50)
  end

  #this is used to "acknowledge a like notification"
  def update
    @like = Like.find(params[:id])
    @like.update(like_params)

    @likes = unacknowledged_likes
    redirect_to likes_path
  end

end

private
  def all_likes
    Like
      .includes(:user, :description)
      .joins(:description)
      .where(descriptions: {user_id: current_user.id})
  end

  def unacknowledged_likes
    all_likes.unacknowledged
  end

  def like_params
    params.require(:like).permit(:acknowledged)
  end

