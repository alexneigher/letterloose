class DescriptionsController < ApplicationController
  before_action :find_title, except: :index
  before_action :authenticate_user!, only: [:upvote, :create]

  def create
    @tweak = @title.tweaks.find(params[:tweak_id])

    @description = @tweak.descriptions.create(description_params.merge(user: current_user))

    @descriptions = @tweak.descriptions.includes(:user, :likes).order(likes_count: :desc, created_at: :desc)

    TwitterService.new(@description.id).delay.post_tweet
  end

  def edit
    @tweak = @title.tweaks.find(params[:tweak_id])
    @description = @tweak.descriptions.find(params[:id])
  end

  def update
    @tweak = @title.tweaks.find(params[:tweak_id])
    @description = @tweak.descriptions.find(params[:id])
    @description.update(description_params)

    @descriptions = @tweak.descriptions.includes(:user, :likes).order(likes_count: :desc).order(created_at: :desc)

    render :create
  end

  def index
    @descriptions = Description.includes(:user, tweak: :title).order(created_at: :desc).page(params[:page]).per(400)
  end

  def upvote
    @source = params[:source]
    @tweak = @title.tweaks.find(params[:tweak_id])
    @description = @tweak.descriptions.find(params[:description_id])

    @description.upvote!(current_user)
    @descriptions = @tweak.descriptions.includes(:user, :likes).order(likes_count: :desc).order(created_at: :desc)

    render :vote
  end

  def show
    @tweak = @title.tweaks.find(params[:tweak_id])
    @description = @tweak.descriptions.includes(:user, tweak: :title).find(params[:id])
  end

  private
    def authenticate_user!
      unless user_signed_in?
        render :error and return
      end
    end

    def find_title
      @title = Title.includes(tweaks: :descriptions).find(params[:title_id])

    end

    def description_params
      params.require(:description).permit(:text)
    end

end
