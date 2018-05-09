class TweakCreateService
  attr_accessor :title, :tweak, :description, :descriptions
  
  def initialize(params, current_user)
    @current_user = current_user
    @params = params.with_indifferent_access
  end

  def perform
    @title = Title.find(@params[:title_id])

    if @params[:description].blank?
      return false
    end

    @tweak = @title.tweaks.find_or_create_by(name: tweak_name) do |t|
      # if you got in here, this is a new tweak
      t.update(user: @current_user)
    end

    @description = @tweak.descriptions.create(text: @params[:description], user: @current_user)

    @descriptions = @tweak.descriptions.includes(:user, :likes).order(likes_count: :desc, created_at: :desc)

    TwitterService.new(@description.id).delay.post_tweet

    return self
  end

  private
    def tweak_name
      @params[:characters].join('').strip
    end

end