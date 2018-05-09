class EmailPreferencesController < ApplicationController

  def show
    redirect_to root_path and return unless current_user.id == params[:user_id].to_i

    @email_preferences = current_user.email_preferences
  end

  def update
    retuern false unless current_user.id == params[:user_id].to_i

    @email_preferences = current_user.email_preferences

    @email_preferences.update(email_preferences_params)

    flash[:success] = 'Your preferences have been updated!'

    redirect_to user_email_preferences_path(current_user)
  end

  private
    def email_preferences_params
      params.require(:email_preferences).permit(:wit_stop, :upvote_notifications)
    end
end
