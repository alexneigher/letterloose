class UpvoteMailer < ApplicationMailer

  def upvoted(upvoter, description)
    @description = description

    @description_author = description.user

    return nil unless @description_author.email_preferences.upvote_notifications?
    headers['X-SMTPAPI'] = '{"category": "Single Upvote"}' #for sendgrid categorization

    @upvoter = upvoter
    mail(to: @description_author.email, subject: "#{@upvoter.username} gave you an upvote!").deliver
  end
  #UpvoteMailer.upvoted(User.where(email: 'aneigher@gmail.com').last, Description.last).deliver_now


  def upvote_summary(user_id, descriptions)
    @user = User.find(user_id)
    @descriptions = descriptions

    return nil unless @user.email_preferences.upvote_notifications?

    headers['X-SMTPAPI'] = '{"category": "Upvote Summary"}' #for sendgrid categorization

    mail(to: @user.email, subject: "You've got some upvotes!")
  end
  #UpvoteMailer.upvote_summary(User.where(email: 'aneigher@gmail.com').last.id, [{text: 'WOW', count: 3},{text: 'The cat', count: 1} ]).deliver
end
