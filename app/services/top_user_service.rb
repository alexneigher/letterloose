class TopUserService


  def initialize
    @descriptions = Description.where("created_at > ?", 1.week.ago)
  end


  def perform
    @descriptions_grouped_to_user_id = @descriptions.group_by(&:user_id)
    sum_user_hashes(@descriptions_grouped_to_user_id)
  end


  private
    def sum_user_hashes(user_id_hash)

      user_hashes = user_id_hash.map do |user_id, descriptions|
                      {
                        username: users_by_id[user_id].first.username,
                        user_id: user_id,
                        count: descriptions.sum(&:likes_count)
                      }
                    end.sort{|a,z|a[:count]<=>z[:count]}.reverse.first(10)
      #returns an array like [{username: alex, id: 1, count: 3}, {},..,..,{}]
    end

    def users_by_id
      @users ||= User.where(id: @descriptions_grouped_to_user_id.keys).group_by(&:id)
    end
end