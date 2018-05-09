class DailyWitStopMailer < ApplicationMailer

  def daily_wit_stop_email(user, daily_wit_stop)
    @description = daily_wit_stop.description
    @user = user
    mail(to: @user.email, subject: "LETTERLOOSE Daily Wit-Stop: #{Date.current.strftime('%b %d, %Y')}")
  end

  #DailyWitStopMailer.daily_wit_stop_email(User.where(email: 'aneigher@gmail.com').last, DailyWitStop.last).deliver_now
end
