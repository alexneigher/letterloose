class CategoriesController < ApplicationController

  def index
    @categories = Category.all

    @highest_rated_descriptions_all_time = descriptions.limit(25)
    @current_weeks_highest_rated_descriptions = descriptions.where("created_at > ?", 7.days.ago).limit(25)
    @most_recent_descriptions = descriptions.reorder(created_at: :desc).limit(25)

    @top_users = TopUserService.new.perform
  end

  def show
    @category = Category.find(params[:id])
    @titles = @category.titles.order(name: :asc).page(params[:page]).per(1500)
  end

  private
    def descriptions
      Description
        .includes(:user, :likes, tweak: :title)
        .order(likes_count: :desc)
    end
end
