class LikesController < ApplicationController

  #used to render your unacknowledged likes
  def index
    @likes = user_signed_in? ? unacknowledged_likes : []
  end


  #this is used to "acknowledge a like notification"
  def update
    @like = Like.find(params[:id])
    @like.update(like_params)

    @likes =unacknowledged_likes
    render :index
  end

end

private
  def unacknowledged_likes
    Like
      .unacknowledged
      .includes(:user, :description)
      .joins(:description)
      .where(descriptions: {user_id: current_user.id})
  end

  def like_params
    params.require(:like).permit(:acknowledged)
  end

