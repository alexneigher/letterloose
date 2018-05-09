module Public
  class EmailPreferencesController < ApplicationController
    layout 'public'

    def update
      #we should refactor this to use a token vs ID to prevent spoofing
      @email_preferences = EmailPreferences.find(params[:id])
      @email_preferences.update(email_preferences_params)
    end


    private
      def email_preferences_params
        params.require(:email_preferences).permit(:wit_stop, :upvote_notifications)
      end

  end
end
