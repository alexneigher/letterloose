class TwitterService

  def initialize(description_id)
    @description = Description.find(description_id)
    @tweak = @description.tweak

    @title = @tweak.title
    @description_url =
      Rails
        .application
        .routes
        .url_helpers
        .title_tweak_description_url(@title, @tweak, @description)
  end

  def post_tweet
    client.update(formatted_description)
  end

 private

  def formatted_description
    "#{@tweak.name} - #{@description.text} http://www.letterloose.com #letterloose".truncate(140)
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end
end