desc 'Send Daily Wit Stop' 
task :send_daily_wit_stop => :environment do

  daily_wit_stop = DailyWitStop.scheduled.last

  abort unless daily_wit_stop

  daily_wit_stop.update(sent: true, sent_at: DateTime.current )

  User.joins(:email_preferences).where(email_preferences: {wit_stop: true}).each do |user|
    DailyWitStopMailer.daily_wit_stop_email(user, daily_wit_stop).deliver_now
  end
end

desc "Send summary of upvotes"
task :send_upvote_summary => :environment do
  likes_by_description_id ||= Like.where("created_at > ?", 24.hours.ago).group(:description_id).count

  descriptions_by_user_id = Description.where(id: likes_by_description_id.keys).group_by(&:user_id)

  descriptions_by_user_id.each do |user_id, descriptions|
    description_like_count = []
    description_like_count << descriptions.map do |d|
                                {text: d.text, count: likes_by_description_id[d.id]}
                              end

    UpvoteMailer.upvote_summary(user_id, description_like_count).deliver_now
  end
end