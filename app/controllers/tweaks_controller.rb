class TweaksController < ApplicationController

  def create
    store_location_and_params
    redirect_to new_user_session_path and return unless user_signed_in?

    service = TweakCreateService.new(params, current_user).perform

    @title = service.title
    @tweak = service.tweak
    @description = service.description
    @descriptions = service.descriptions

    @create = true
    render :show
  end

  def show
    @title = Title.find(params[:title_id])
    @tweak = @title.tweaks.find(params[:id])
    @descriptions = @tweak.descriptions.includes(:user, :likes).order(likes_count: :desc, created_at: :desc)
  end

  private
    def store_location_and_params
      session[:tweak_params] = params unless user_signed_in?
    end
end
